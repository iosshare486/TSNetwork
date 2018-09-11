//
//  TSNormalRequestBaseModel.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/9/11.
//  Copyright © 2018年 caiqr. All rights reserved.
//  默认数据解析模型 如果结构不同可弃用

import UIKit

open class TSNormalRequestBaseModel<T : TSMoyaAddable>: TSMoyaAddable {
    var code : Int?
    var msg : String?
    var resp : Array<T>?
    required public init () { }
}
