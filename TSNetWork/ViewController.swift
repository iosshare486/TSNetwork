//
//  ViewController.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/6/4.
//  Copyright © 2018年 caiqr. All rights reserved.
//

import UIKit
import Reachability

var reachability: Reachability!
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view, typically from a nib.
        
        TSNetworkMonitor.shared.startNotifier { [weak self] (status) in
            let view = UIView.init(frame: CGRect(x: 20, y: 0, width: 100, height: 50))
            if status {
                view.backgroundColor = .green
            } else {
                view.backgroundColor = .red
            }
            self?.view.addSubview(view)
        }
        if TSNetworkMonitor.shared.reachabilityStatus == listenerStatus.tsWan {
            let view = UIView.init(frame: CGRect(x: 200, y: 0, width: 100, height: 50))
            
            view.backgroundColor = .red
            self.view.addSubview(view)
        } else if TSNetworkMonitor.shared.reachabilityStatus == listenerStatus.tsFiwi {
            let view = UIView.init(frame: CGRect(x: 0, y: 200, width: 100, height: 50))
            
            view.backgroundColor = .red
            self.view.addSubview(view)
        }
    
        let api = TSCustomDemoAPI.init()
        api.HTTPMethod = .tsGet
        api.path = "/app_list"
        api.parameter = ["aaa" : "bbbb"]
        TSNetworkManager<TSDemoModel>.send(api, completion: { (response) in
            print("\(response.jsonData)")
        }) { (error) in
            print("\(error) ")
            if error.networkType == listenerStatus.tsNoNet {
                
            } else if error.networkType == listenerStatus.tsFiwi {
                
            } else if error.networkType == listenerStatus.tsWan {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

