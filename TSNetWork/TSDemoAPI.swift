//
//  TSDemoAPI.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/6/7.
//  Copyright © 2018年 caiqr. All rights reserved.
//

import Foundation

class TSCustomBaseAPI : TSBaseRequest {
    required init() {
        super.init()
    }

    override var timeoutInterval: TimeInterval? {
        set { }
        get {
           return 10
        }
    }
    override func tsRequestUrl() -> String? {
        return "http://zlrun.cn"
    }
    override func tsRequestHeader() -> [String : String]? {
        
        
        
        return ["User-Agent" : " Client/10001"]
    }
}

