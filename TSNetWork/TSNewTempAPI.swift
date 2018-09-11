//
//  TSNewTempAPI.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/9/11.
//  Copyright © 2018年 caiqr. All rights reserved.
//

import UIKit

class TSNewTempAPI: TSBasicRequest<TSDemoBaseModel<TSDemoModel>> {
    override func configResp(_ jsonObject: [String : Any]) -> TSDemoBaseModel<TSDemoModel> {
        let model = TSBaseResponse.ts_deserializeModelFrom(dict: jsonObject) as TSDemoBaseModel<TSDemoModel>
        return model
    }
}
