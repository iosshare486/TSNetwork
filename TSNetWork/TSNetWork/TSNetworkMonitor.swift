//
//  TSNetworkMonitor.swift
//  TSNetWork
//
//  Created by 小铭 on 2018/6/15.
//  Copyright © 2018年 caiqr. All rights reserved.
//  网络监听

import UIKit
import Reachability

public class TSNetworkMonitor  {
    let reachability = Reachability()
    //当前网络状态
    var reachabilityStatus : listenerStatus {
        set {
            
        }
        get {
            // 检测网络类型
            if reachability!.connection == .wifi {
                return listenerStatus.tsFiwi
            } else if reachability!.connection == .cellular {
                return listenerStatus.tsWan
            } else if reachability!.connection == .none {
                return listenerStatus.tsNoNet
            } else {
                return listenerStatus.tsOther
            }
        }
    }
    
    static let shared = TSNetworkMonitor.init()
    private init() { }
    //开始网络监听
    public func startNotifier (monitorStatus : @escaping (Bool) -> () ) {
        
        reachability!.whenReachable = { reachability in
            monitorStatus(true)
        }
        reachability!.whenUnreachable = { reachability in
            monitorStatus(false)
        }
        do {
            // 开始监听
            try reachability!.startNotifier()
        } catch {
            
        }
    }
    //停止网络监听
    public func stopNotifier () {
        reachability!.stopNotifier()
    }
}
