//
//  ViewController.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/6/4.
//  Copyright © 2018年 caiqr. All rights reserved.
//

import UIKit
import TSNetworkMonitor

class ViewController: UIViewController {
    var customAPI = TSBasicRequest<TSDemoModel>()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        customAPI.parameter = ["adb" : "ddd"]
        
        // Do any additional setup after loading the view, typically from a nib.        
        TSNetworkMonitor.shared.addNetworkNotification(self, #selector(chengNet))
//        TSNetworkMonitor.shared.startNotifier { [weak self] (status) in
//            let view = UIView.init(frame: CGRect(x: 20, y: 0, width: 100, height: 50))
//            if status {
//                view.backgroundColor = .green
//            } else {
//                view.backgroundColor = .red
//            }
//            self?.view.addSubview(view)
//        }
//        if TSNetworkMonitor.shared.reachabilityStatus == listenerStatus.tsWan {
//            let view = UIView.init(frame: CGRect(x: 200, y: 0, width: 100, height: 50))
//
//            view.backgroundColor = .red
//            self.view.addSubview(view)
//        } else if TSNetworkMonitor.shared.reachabilityStatus == listenerStatus.tsFiwi {
//            let view = UIView.init(frame: CGRect(x: 0, y: 200, width: 100, height: 50))
//
//            view.backgroundColor = .red
//            self.view.addSubview(view)
//        }
//        TSNetworkMonitor.shared.stopNotifier()
//        let api = TSCustomDemoAPI.init()
//        api.HTTPMethod = .tsGet
//        TSNetworkManager.send(api, completion: { (response) in
//            print("\(response.jsonObject)")
//            let respT : [Any] = response.jsonObject["resp"] as! [Any]
//            var Arr : [TSDemoItemModel] = TSBaseResponse.ts_deserializeModelArrFrom(arr: respT)
//
//        }) { (error) in
//            print("\(error) ")
//            let code = error.code
//            let message  = error.message
//            let urlError = error.error
//            let netType = error.networkType
//            if error.networkType == listenerStatus.tsNoNet {
//
//            } else if error.networkType == listenerStatus.tsFiwi {
//
//            } else if error.networkType == listenerStatus.tsWan {
//
//            }
//        }
    }

    @objc func chengNet () {
        if TSNetworkMonitor.shared.reachabilityStatus == TSListenerStatus.tsNoNet {
            view.backgroundColor = .red
        } else {
            view.backgroundColor = .green
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

