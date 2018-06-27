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

public class TSBaseResponse{

    public var code: Int {
        guard let temp = jsonObject["code"] as? Int else {
            return -1
        }
        return temp
    }
    
    public var errorMessage: String? {
        guard let temp = jsonObject["msg"] as? String else {
            return ""
        }
        return temp
    }
    
    public var jsonObject: [String : Any]
    required public init() {
        jsonObject = ["":""]
    }
    init?(data: Any) {
        guard let temp = data as? [String : Any] else {
            return nil
        }
        self.jsonObject = temp
//        let resp = self.jsonData["resp"]
//        if let arrFistDic = (resp as? Array<Any>)?.first as? NSDictionary {
//            self.responeObject = JSONDeserializer<T>.deserializeFrom(dict: arrFistDic)
//        }
//        if let dic = resp as? Dictionary<String, Any> {
//            self.responeObject = JSONDeserializer<T>.deserializeFrom(dict: dic)
//        }
//        if let dicString = resp as? String {
//            self.responeObject = JSONDeserializer<T>.deserializeFrom(json: dicString)
//        }
//        self.responeObject.objectToModelFinish()
    }
//    public var responeObject: T! = T()
    
}

public extension TSBaseResponse {
    //通过dict转Model
    public class func ts_deserializeModelFrom<T : TSMoyaAddable> (dict : [String : Any]) -> T{
        var model = T()
        if let modelT = JSONDeserializer<T>.deserializeFrom(dict: dict) {
            model = modelT
            model.objectToModelFinish()
        }
        return model
    }
    public class func ts_deserializeModelFrom<T : TSMoyaAddable> (dict : NSDictionary) -> T{
        var model = T()
        if let modelT = JSONDeserializer<T>.deserializeFrom(dict: dict) {
            model = modelT
            model.objectToModelFinish()
        }
        return model
    }
    //通过jsonString转Model
    public class func ts_deserializeModelFrom<T : TSMoyaAddable> (json : String) -> T{
        var model = T()
        if let modelT = JSONDeserializer<T>.deserializeFrom(json: json) {
            model = modelT
            model.objectToModelFinish()
        }
        return model
    }
    //通过数组转模型数组
    public class func ts_deserializeModelArrFrom<T : TSMoyaAddable> (arr : [Any]) -> [T]{
        var modelArr : [T] = []
        if let modelTArr = JSONDeserializer<T>.deserializeModelArrayFrom(array: arr) {
            modelArr = modelTArr as! [T]
        }
        return modelArr
    }
    public class func ts_deserializeModelArrFrom<T : TSMoyaAddable> (arr : NSArray) -> [T]{
        var modelArr : [T] = []
        if let modelTArr = JSONDeserializer<T>.deserializeModelArrayFrom(array: arr) {
            modelArr = modelTArr as! [T]
        }
        return modelArr
    }
    public class func ts_deserializeModelArrFrom<T : TSMoyaAddable> (jsonString : String) -> [T]{
        var modelArr : [T] = []
        if let modelTArr = JSONDeserializer<T>.deserializeModelArrayFrom(json: jsonString) {
            modelArr = modelTArr as! [T]
        }
        return modelArr
    }
}

public extension TSMoyaAddable {
    
    func objectToModelFinish () {
        
    }
}
