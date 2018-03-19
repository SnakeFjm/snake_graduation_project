////
////  BaseWebViewControllerExtension.swift
////  sanshi
////
////  Created by dev on 2017/10/11.
////  Copyright © 2017年 Chensh. All rights reserved.
////
//
//import UIKit
//import SwiftyJSON
//
//extension BaseWebViewController {
//
//
//    // ************************************
//    // MARK:
//    // ************************************
//
//    @objc func webviewEvaluateJavaScript(script: String) {
//        DispatchQueue.main.async {
//            self.webView.evaluateJavaScript(script, completionHandler: nil)
//        }
//    }
//
//    // =================================
//    // MARK:
//    // =================================
//
//    // 进入本地某个页面
//    func openViewController(_ dict: [String: AnyObject]) {
//        // 获取参数
//        if let paramDict: NSDictionary = dict["params"] as? NSDictionary {
//            if let viewControllerName: String = paramDict.object(forKey: "viewControllerName") as? String {
//                // 将字符串转换为类
//                if let viewControllClassType = NSClassFromString("sanshi." + viewControllerName) as? UIViewController.Type {
//                    let instance = viewControllClassType.init()
//                    self.push(instance)
//                }  else {
//                    debugPrint("无法转为视图控制器类：\(viewControllerName)")
//                    return
//                }
//            }
//        }
//    }
//
//
//    // ================================
//    // MARK:
//    // ================================
//
//    // 获取用户token
//    @objc func getToken(_ paramDict: NSDictionary) {
//        let token = UserManager.shared.tokenModel.token
//        let dict: JSON = JSON(["method" : "getTokenCallback",
//                               "params" : token])
//        guard let result: String = dict.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.prettyPrinted) else {
//            return
//        }
//        let script: String = "h5Handler('\(result)')"
//        self.webviewEvaluateJavaScript(script: script)
//    }
//
//
//}
//
