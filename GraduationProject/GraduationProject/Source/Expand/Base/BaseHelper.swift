//
//  BaseHelper.swift
//  FoodDetect
//
//  Created by dev on 2017/10/21.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit
import QMUIKit



// ================================
// MARK: 相册授权访问
// ================================

typealias AuthorzationCompletion = (_ success: Bool) -> ()


func authorizationPresentAlbumViewController(_ completion: AuthorzationCompletion?) {
    if QMUIAssetsManager.authorizationStatus() == QMUIAssetAuthorizationStatus.notDetermined {
        QMUIAssetsManager.requestAuthorization({ (status: QMUIAssetAuthorizationStatus) in
            if completion != nil {
                completion!(status == QMUIAssetAuthorizationStatus.authorized)
            }
        })
    } else {
        if completion != nil {
            completion!(true)
        }
    }
}


