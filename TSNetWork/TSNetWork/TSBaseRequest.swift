//
//  TSBaseRequest.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/6/7.
//  Copyright © 2018年 caiqr. All rights reserved.
//

import Foundation
import Alamofire

protocol TSRequestProtocol {
    var tsBaseUrl : String? { get }
    var tsHeaderS : [String : String]? { get }
}

enum TSRequestMethod : String {
    case tsPost = "POST"
    case tsGet = "GET"
}

class TSBaseRequest : TSRequestProtocol{
    
    var tsBaseUrl: String?
    
    var tsHeaderS: [String : String]?
    
    required init() { }
    
    //默认请求session NetworkManager内根据BaseRequest修改
    static var sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()
    //请求path
    var path: String = ""
    //特定请求域名
    var privateHost: String?
    //请求方式
    var HTTPMethod: TSRequestMethod = .tsGet
    //请求超时时间
    var timeoutInterval: TimeInterval?
    //请求参数
    var parameter: [String:Any]?
    //请求特殊策略域名
    var particularHost : String?
}
