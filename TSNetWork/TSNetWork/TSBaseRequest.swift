//
//  TSBaseRequest.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/6/7.
//  Copyright © 2018年 caiqr. All rights reserved.
//

import Foundation
import Alamofire

@objc public protocol TSRequestProtocol {
    
}

public enum TSRequestMethod : String {
    case tsPost = "POST"
    case tsGet = "GET"
}

open class TSBaseRequest : TSRequestProtocol{
    
    required public init() { }
    
    //默认请求session NetworkManager内根据BaseRequest修改
    static var sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()
    //请求path
    open var path: String = ""
    //请求方式
    open var HTTPMethod: TSRequestMethod = .tsGet
    //请求超时时间
    open var timeoutInterval: TimeInterval?
    //请求参数
    open var parameter: [String:Any]?
    //请求特殊策略域名
    open var particularHost : String?
    //配置请求URL
    open func tsRequestUrl() -> String? {
        return nil
    }
    //配置请求头
    open func tsRequestHeader() -> [String : String]? {
        return nil
    }
    
}
