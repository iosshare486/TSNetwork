//
//  TSBasicRequest.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/9/10.
//  Copyright © 2018年 caiqr. All rights reserved.
//  拓展网络请求创建方式 如果弃用可用TSBaseRequest

import Foundation

open class TSBasicRequest<T : TSMoyaAddable> : TSBaseRequest {
    
    required public init() {}
    //数据解析方法 可子类覆盖实现
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
