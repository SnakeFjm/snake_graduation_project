//
//  UIViewController.swift
//  FoodDetect
//
//  Created by dev on 2017/10/21.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit
import QMUIKit
import MobileCoreServices
import SVProgressHUD

extension UIViewController {
    
    // =================================
    // MARK:
    // =================================
    
    // 推入控制器
    func push(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    // 返回堆栈的某个类
    func backToClass(className: AnyClass) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController.isKind(of: className) {
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
        }
    }
    
    @IBAction func back() {
        if self.qmui_isPresented() {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}




// 提示
extension UIViewController {
    
//    // =================================
//    // MARK:
//    // =================================
//    
//    func showSuccessTips(_ tips: String) {
//        SVProgressHUD.setDefaultMaskType(.none)
//        SVProgressHUD.setMinimumDismissTimeInterval(2.5)
//        SVProgressHUD.showSuccess(withStatus: tips)
//    }
//    
//    func showErrorTips(_ tips: String) {
//        SVProgressHUD.setDefaultMaskType(.none)
//        SVProgressHUD.setMinimumDismissTimeInterval(2.5)
//        SVProgressHUD.showError(withStatus: tips)
//    }
//    
//    func showLoadingTips(_ tips: String) {
//        SVProgressHUD.setDefaultMaskType(.black)
//        SVProgressHUD.setMinimumDismissTimeInterval(2.5)
//        SVProgressHUD.show(withStatus: tips)
//    }
//    
//    func hideTips() {
//        SVProgressHUD.dismiss()
//    }
    
    
}





