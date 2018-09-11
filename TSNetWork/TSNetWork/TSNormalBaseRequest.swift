//
//  TSNormalBaseRequest.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/9/11.
//  Copyright © 2018年 caiqr. All rights reserved.
//  默认请求模型 需要自定义可重新创建基类

import UIKit

open class TSNormalBaseRequest<T : TSMoyaAddable>: TSBasicRequest<TSNormalRequestBaseModel<T>> {
    override open var HTTPMethod: TSRequestMethod {
        get {
            return .tsPost
        }
        set { }
    }
}
