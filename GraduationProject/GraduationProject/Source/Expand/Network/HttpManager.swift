//
//  HttpManager.swift
//  JKOSX
//
//  Created by dev on 2017/11/10.
//  Copyright © 2017年 Chensh. All rights reserved.
//

import Alamofire
import SwiftyJSON
import SVProgressHUD


class HttpManager: NSObject {

    static let shared: HttpManager = HttpManager.init()
    
    
    override init() {
        super.init()
        //
        self.updateHttpsSession()
    }
    
    func headers() -> HTTPHeaders {
        //
        var tempHeaders: HTTPHeaders = ["Request-Id" : UUID.init().uuidString]
        //
        if UserManager.shared.userModel != nil {
//            tempHeaders["Authorization"] = UserManager.shared.userModel.token
        }
        //
        return tempHeaders
    }
    
    
    // 更改https信任
    func updateHttpsSession() {
        SessionManager.default.delegate.sessionDidReceiveChallenge = {
            (session, challenge) in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            challenge.sender?.use(credential, for: challenge)
            return (.useCredential, credential)
        }
    }

    
    
    // =================================
    // MARK: Request
    // =================================
    
    func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        //
        let currentHeaders: HTTPHeaders = (headers == nil ? self.headers() : headers!)
        self.printRequestInfo(url, method: method, parameters: parameters, headers: currentHeaders)
        //
        return Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: currentHeaders)
    }
    
    // =================================
    // MARK: POST
    // =================================
    
    func postRequest(_ url: URLConvertible, parameters: Parameters? = nil) -> DataRequest {
        return self.request(url, method: .post, parameters: parameters, encoding: URLEncoding(destination: .httpBody))
    }
    
    func postRequest(_ url: URLConvertible, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default) -> DataRequest {
        return self.request(url, method: .post, parameters: parameters, encoding: encoding)
    }
    
    
    // =================================
    // MARK: Get
    // =================================
    
    func getRequest(_ url: URLConvertible, parameters: Parameters? = nil) -> DataRequest {
        return self.request(url, method: .get, parameters: parameters, encoding: URLEncoding(destination: .methodDependent))
    }
    
    
    // 分页
    func getRequest(_ url: URLConvertible, pageNum: Int, pageSize: Int,  parameters: Parameters? = nil) -> DataRequest {
        
        if parameters != nil {
            
            var paramDict = parameters!
            paramDict["pageNum"] = pageNum
            paramDict["pageSize"] = pageSize
            return self.request(url, method: .get, parameters: paramDict, encoding: URLEncoding(destination: .methodDependent), headers: self.headers())
            
        } else {
            
            let paramDict: Parameters = ["pageNum" : pageNum,
                                         "pageSize" : pageSize]
            return self.request(url, method: .get, parameters: paramDict, encoding: URLEncoding(destination: .methodDependent))
        }
    }
    
    // =================================
    // MARK: Put
    // =================================
    
    func putRequest(_ url: URLConvertible, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default) -> DataRequest {
        return self.request(url, method: .put, parameters: parameters, encoding: encoding)
    }
    
    // =================================
    // MARK: Delete
    // =================================
    
    func deleteRequest(_ url: URLConvertible, parameters: Parameters? = nil) -> DataRequest {
        return self.request(url, method: .delete, parameters: parameters)
    }
    
    
    // =================================
    // MARK: Multipart
    // =================================
    
    func multipartRequest(_ url: URLConvertible, imageData: Data, name: String, fileName: String, mimeType: String, method: HTTPMethod = .post, encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        //
        let headers = self.headers()
        self.printRequestInfo(url, method: method, parameters: nil, headers: headers)
        //
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
        }, to: url, method: method, headers: headers, encodingCompletion: encodingCompletion)
    }
    
    
    // 上传检测图片
    func uploadDetectImage(_ url: URLConvertible, imageData: Data, name: String, fileName: String, mimeType: String, encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        //
        let headers = self.headers()
        self.printRequestInfo(url, method: .post, parameters: nil, headers: headers)
        //
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
        }, to: url, method: .post, headers: headers, encodingCompletion: encodingCompletion)
    }
    
    
    // =================================
    // MARK: 打印信息
    // =================================
    
    func printRequestInfo(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders) {
        debugPrint("==================================")
        debugPrint(method.rawValue)
        debugPrint(url)
        debugPrint("==================================")
        for (key, value) in headers {
            debugPrint("\(key) : \(value)")
        }
        debugPrint("==================================")
        if parameters != nil {
            for (key, value) in parameters! {
                debugPrint("\(key) : \(value)")
            }
        }
        debugPrint("==================================")
    }
    
    static func printResponseData(result: JSON) {
        debugPrint(result)
        debugPrint("==================================")
    }
    
    // =================================
    // MARK: 检测JSON结果是否保存错误
    // =================================
    
    // 返回 nil 则表示存在error错误
    // 否则，直接返回解析出来的JSON
    static func parseDataResponse(_ response: DataResponse<Any>) -> JSON? {
        //
        switch response.result {
        case .success(let obj):
            let result: JSON = JSON.init(obj)
            printResponseData(result: result)
            //
            if let code = result["code"].int, code != 0, let msg: String = result["msg"].string {
                handlerError(code: code, msg: msg)
            } else {
                return result
            }
            
        case .failure(let error):
            debugPrint(error)
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }
        return nil
    }
    
    
    // 处理错误信息
    static func handlerError(code: Int, msg: String) {
        //
        SVProgressHUD.showError(withStatus: "\(code)\n\(msg)")
        //
        switch code {
        case 401: // token无效
            //
            UserManager.shared.removeUserModel()
            //
            NotificationCenter.default.post(name: K_LOGIN_STATUS_CHANGE, object: nil)
            
        default:
            break
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    // 判断是否能够加载更多
    
    static func checkIfCanLoadMore(currentPage: Int, result: JSON) -> Bool {
        let totalPage = result["totalPage"].intValue
        if currentPage >= totalPage - 1 {
            return false
        }
        return true
    }
}
