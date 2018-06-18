//
//  TSBaseResponse.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/6/6.
//  Copyright © 2018年 caiqr. All rights reserved.
//  接口返回统一Response

import UIKit
import HandyJSON

public protocol TSMoyaAddable : HandyJSON {
    //自定义API
    func objectToModelFinish ()
    
}

class TSBaseResponse<T : TSMoyaAddable>{

    var code: Int {
        guard let temp = jsonData["code"] as? Int else {
            return -1
        }
        return temp
    }
    
    var errorMessage: String? {
        guard let temp = jsonData["msg"] as? String else {
            return ""
        }
        return temp
    }
    
    var jsonData: [String : Any]
    required init() {
        jsonData = ["":""]
    }
    init?(data: Any) {
        guard let temp = data as? [String : Any] else {
            return nil
        }
        self.jsonData = temp
        let resp = self.jsonData["resp"]
        if let arrFistDic = (resp as? Array<Any>)?.first as? NSDictionary {
            self.responeObject = JSONDeserializer<T>.deserializeFrom(dict: arrFistDic)
        }
        if let dic = resp as? Dictionary<String, Any> {
            self.responeObject = JSONDeserializer<T>.deserializeFrom(dict: dic)
        }
        if let dicString = resp as? String {
            self.responeObject = JSONDeserializer<T>.deserializeFrom(json: dicString)
        }
    }
    var responeObject: T! = T()
    
}

extension TSMoyaAddable {
    
    func objectToModelFinish () {
        
    }
}
