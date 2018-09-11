//
//  TSDemoModel.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/6/7.
//  Copyright © 2018年 caiqr. All rights reserved.
//

import UIKit

struct TSDemoBaseModel<T : TSMoyaAddable> : TSMoyaAddable {
    var code : Int?
    var resp : Array<T>?
    var msg : String?
}



struct TSDemoModel : TSMoyaAddable {
    var respObject: Any? {
        return "1234"
    }
    
    var resp : Array<TSDemoItemModel>?
}

struct TSDemoItemModel : TSMoyaAddable {
    
    var respObject: Any?
    
    func objectToModelFinish() { }
    var id : String?
    var app_name : String?
    var app_icon : String?
    var app_client : String?
    var app_type : String?
    
}
