//
//  TSNetworkError.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/6/4.
//  Copyright © 2018年 caiqr. All rights reserved.
//

import Foundation
import Alamofire

public enum listenerStatus {
    case tsFiwi
    case tsWan
    case tsOther
    case tsNoNet
}

public struct ResponseCode {
    static let successResponseStatus = 0     // 接口成功调用
}

// 网络错误处理枚举
public enum TSNetworkError: Error  {
    // json解析失败
    case jsonSerializationFailed(message: String)
    // json转字典失败
    case jsonToDictionaryFailed(message: String)
    // 请求返回的错误
    case respResponse(message: String?, code: Int, error: URLError)
    // 服务器返回的错误
    case serverResponse(message: String?, code: Int)
    // NoNetworkError
    case noNetworkResponse(message: String?, code: Int)
    // 自定义错误
    case exception(message: String)
}

public extension TSNetworkError {
    public var message: String? {
        switch self {
        case let .respResponse(msg, _, _):
            return msg
        case let .serverResponse(msg, _):
            return msg
        case let .noNetworkResponse(msg, _):
            return msg
        default:
            return nil
        }
    }
    
    public var code: Int {
        switch self {
        case let .serverResponse(_, code):
            return code
        case let .respResponse(_, code, _):
            return code
        case let .noNetworkResponse(_, code):
            return code
        default:
            return -1
        }
    }
    
    public var error : URLError? {
        switch self {
        case let .respResponse(_, _,error):
            return error
        default:
            return nil
        }
    }
    
    public var networkType : listenerStatus? {
        switch self {
        default:
            var listenerstatus : listenerStatus?
            if let manager = NetworkReachabilityManager.init() {
                if manager.isReachable {
                    if manager.isReachableOnWWAN {
                        listenerstatus = listenerStatus.tsWan
                    } else if manager.isReachableOnEthernetOrWiFi {
                        listenerstatus = listenerStatus.tsFiwi
                    } else {
                        listenerstatus = listenerStatus.tsOther
                    }
                } else {
                    listenerstatus = listenerStatus.tsNoNet
                }
            }
            return listenerstatus!
        }
    }
}
