//
//  TSNormalBaseRequest.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/9/11.
//  Copyright © 2018年 caiqr. All rights reserved.
//  默认请求模型 需要自定义可重新创建基类

import UIKit

/// 默认通用请求基础类，泛型需要子类传入，或是创建时指定
open class TSNormalBaseRequest<T : TSMoyaAddable>: TSBasicRequest<TSNormalRequestBaseModel<T>> {
    override open var HTTPMethod: TSRequestMethod {
        get {
            return .tsPost
        }
        set { }
    }
}
