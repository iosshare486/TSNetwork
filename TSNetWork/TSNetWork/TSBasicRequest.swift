//
//  TSBasicRequest.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/9/10.
//  Copyright © 2018年 caiqr. All rights reserved.
//

import Foundation
import Alamofire

open class TSBasicRequest<T : TSMoyaAddable> : TSBaseRequest {
    
    required public init() {}
    
    open func configResp (_ jsonObject : [String : Any]) -> T {
        return TSBaseResponse.ts_deserializeModelFrom(dict: jsonObject) as T
    }
    
    //开始请求
    open func tsStartRequest (_ completion: @escaping ((T) -> ()),
                              _ error: @escaping (TSNetworkError) -> ()) {
        TSNetworkManager.send(self, completion: { [weak self] (resp) in
            if let tempT = self?.configResp(resp.jsonObject) {
                completion(tempT)
            } else {
                debugPrint("数据转模型失败")
                completion(T())
            }
        }, error: error)
    }
}

extension TSBasicRequest {
    //默认请求session NetworkManager内根据BaseRequest修改
//    static var sharedSessionManager: Alamofire.SessionManager = {
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 10
//        return Alamofire.SessionManager(configuration: configuration)
//    }()
}
