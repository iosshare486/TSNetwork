//
//  TSNewTempAPI.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/9/11.
//  Copyright © 2018年 caiqr. All rights reserved.
//

import UIKit

class TSNewTempAPI<T : TSMoyaAddable>: TSNormalBaseRequest<T> {
    override var path: String {
        set { }
        get {
            return "/api"
        }
    }
    override func tsRequestUrl() -> String? {
        return ""
    }
}
