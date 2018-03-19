////
////  UploadImageManager.swift
////  renbo
////
////  Created by Chensh on 2018/1/10.
////  Copyright © 2018年 iAskDoc Technology. All rights reserved.
////
//
//import Foundation
//
//typealias UploadImageCompletion = (_ imageUrl: String?) -> ()
//
//
//class UploadImageManager {
//
//
//    static func upload(imageData: Data, completion: @escaping UploadImageCompletion) {
//        //
//        let apiName = URLManager.base_file()
//        //
//        HttpManager.shared.multipartRequest(apiName, imageData: imageData, name: "file", fileName: "1.jpg", mimeType: "jpg") {
//            (encodingResult) in
//            //
//            switch encodingResult {
//            case .success(let request, _, _):
//                //
//                request.responseJSON(completionHandler: {
//                    (response) in
//                    if let result = HttpManager.parseDataResponse(response) {
//                        completion(result["url"].string)
//                    } else {
//                        completion(nil)
//                    }
//                })
//            case .failure(let error):
//                debugPrint(error)
//                completion(nil)
//            }
//        }
//    }
//
//
//}

