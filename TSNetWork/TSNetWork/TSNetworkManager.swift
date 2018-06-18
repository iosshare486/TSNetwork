//
//  TSNetworkManager.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/6/4.
//  Copyright © 2018年 caiqr. All rights reserved.
//  网络管理

import Foundation
import Alamofire
import HandyJSON


class TSNetworkManager<T> where T: TSMoyaAddable {
    
    public func send<R: TSBaseRequest>(
        _ type: R,
        completion: @escaping ((TSBaseResponse<T>) -> ()),
        error: @escaping (TSNetworkError) -> () )
    {
        request(type, modelComletion: completion, error: error)
    }
    
    // 用来处理只请求一次的栅栏队列
    private let barrierQueue = DispatchQueue(label: "cn.ts.NetworkManager", attributes: .concurrent)
    // 用来处理只请求一次的数组,保存请求的信息 唯一
    private var fetchRequestKeys = [String]()
}

extension TSNetworkManager {
    
    
    /// 请求基类方法
    ///
    /// - Parameters:
    ///   - type: BaseRequest
    ///   - modelComletion: 普通接口返回数据闭包
    ///   - modelListComletion: 列表接口返回数据闭包
    ///   - error: 错误信息返回闭包
    /// - Returns: 可以用来取消请求
    
    private func request<R: TSBaseRequest>(
        _ type: R,
        modelComletion: ((TSBaseResponse<T>) -> ())? = nil,
        error: @escaping (TSNetworkError) -> () )
    {
        // 同一请求正在请求直接返回
        if isSameRequest(type) {
            return
        }
        //请求url
        guard type.tsBaseUrl != nil else {
            return
        }
        let urlString = type.privateHost ?? type.tsBaseUrl!.appending(type.path)
        guard let _ : URL = URL(string: urlString) else {
            return
        }
        
        //配置请求头
        var afHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        if var headers : [String : String] = type.tsHeaderS {
            //此处可设置httpheaders 同时自定义User-agent
            for e in headers {
                afHeaders[e.key] = headers[e.key]
            }
        }
        
        //设置请求超时时间
        if let outTime = type.timeoutInterval {
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = outTime   // 秒
            TSBaseRequest.sharedSessionManager = Alamofire.SessionManager(configuration: config)
        }
        //设置特殊域名证书策略
        if let particularHostString = type.particularHost {
            let config: URLSessionConfiguration = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = type.timeoutInterval ?? 10
            
            let serTrusePolicy = ServerTrustPolicy.pinCertificates(certificates: ServerTrustPolicy.certificates(), validateCertificateChain: true, validateHost: true)
            let serverTruckPolicies : [String:ServerTrustPolicy] = [particularHostString : serTrusePolicy]
            
            let serverTruckPolicyManager = ServerTrustPolicyManager(policies: serverTruckPolicies)
            
            TSBaseRequest.sharedSessionManager = Alamofire.SessionManager(configuration: config, delegate: SessionManager.default.delegate, serverTrustPolicyManager: serverTruckPolicyManager)
        }
        //开始请求
        TSBaseRequest.sharedSessionManager.request(urlString, method: HTTPMethod(rawValue: type.HTTPMethod.rawValue)!, parameters: type.parameter ?? nil, encoding: URLEncoding.default, headers: afHeaders).validate(statusCode: 200..<300).responseJSON(completionHandler: { (resp) in
            resp.result.ifSuccess {
                //移除请求
                self.cleanRequest(type)
                //回调数据
                self.handleSuccessResponse(response: resp.data!, modelComletion: modelComletion, error: error)
            }
            resp.result.ifFailure {

                if let errorS = resp.error as? URLError {
                    switch errorS.errorCode {
                    case -1001:
                        error(TSNetworkError.serverResponse(message: "请求超时", code: errorS.code.rawValue))
                    case -1009:
                        error(TSNetworkError.noNetworkResponse(message: "无法连接到网络", code: errorS.code.rawValue))
                    default:
                        error(TSNetworkError.networkResponse(message: "当前网络不稳定，请重试", code: errorS.code.rawValue, error: errorS))
                        break
                    }
                } else {
                    error(TSNetworkError.exception(message: "当前网络不稳定，请重试"))
                }
            }
        })
    }
    
    //处理成功的返回
    private func handleSuccessResponse(
        response: Data,
        modelComletion: ((TSBaseResponse<T>) -> ())? = nil,
        error: @escaping (TSNetworkError) -> ())
    {
        do {
            if let temp = modelComletion {
                let listResponse = try handleResponseData(data: response)
                temp(listResponse)
            }
        } catch let TSNetworkError.serverResponse(message, code) {
            error(TSNetworkError.serverResponse(message: message, code: code))
        } catch let TSNetworkError.jsonToDictionaryFailed(message) {
            error(TSNetworkError.jsonToDictionaryFailed(message: message))
        } catch {
            #if Debug
            fatalError("未知错误")
            #endif
        }
    }
    
    // 处理数据
    private func handleResponseData(data: Data) throws -> (TSBaseResponse<T>) {
        guard let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []) else {
            throw TSNetworkError.jsonSerializationFailed(message: "JSON解析失败")
        }
        let response: TSBaseResponse<T> = TSBaseResponse<T>.init(data: jsonAny)!
        guard response.responeObject != nil else {
            throw TSNetworkError.jsonToDictionaryFailed(message: "JSON转字典失败")
        }
        
        if response.code != ResponseCode.successResponseStatus {
            throw TSNetworkError.serverResponse(message: response.errorMessage, code: response.code)
        }
        return (response)
    }
}

// 保证同一请求同一时间只请求一次
extension TSNetworkManager {
    private func isSameRequest<R: TSBaseRequest>(_ type: R) -> Bool {
        let key = type.path + type.parameter!.description
            var result: Bool!
            barrierQueue.sync(flags: .barrier) {
                result = fetchRequestKeys.contains(key)
                if !result {
                    fetchRequestKeys.append(key)
                }
            }
        return result
    }
    
    private func cleanRequest<R: TSBaseRequest>(_ type: R) {
            let key = type.path + type.parameter!.description
            _ = barrierQueue.sync(flags: .barrier) {
                if let index = fetchRequestKeys.index(of: key) {
                    fetchRequestKeys.remove(at: index)
                }
            }
    }
}
