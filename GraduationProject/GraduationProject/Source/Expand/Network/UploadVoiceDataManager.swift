////
////  UploadVoiceDataManager.swift
////  renbo
////
////  Created by Chensh on 2018/3/14.
////  Copyright © 2018年 iAskDoc Technology. All rights reserved.
////
//
//import Foundation
//
//
//
//typealias UploadVoiceDataCompletion = (_ imageUrl: String?) -> ()
//
//
//class UploadVoiceDataManager {
//    
//    
//    static func upload(voiceData: Data, completion: @escaping UploadVoiceDataCompletion) {
//        //
//        let apiName = URLManager.base_file()
//        //
//        HttpManager.shared.multipartRequest(apiName, imageData: voiceData, name: "file", fileName: "\(UUID.init().uuidString).amr", mimeType: "amr") {
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

