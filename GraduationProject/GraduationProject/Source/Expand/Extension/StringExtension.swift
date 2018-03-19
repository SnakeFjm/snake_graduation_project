//
//  StringExtension.swift
//  FoodDetect
//
//  Created by Snake on 2017/12/15.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import Foundation
import Alamofire


extension String: ParameterEncoding {
    
    // http 请求参数编码
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
    
    // url 编码
    func urlEncoding() -> String? {
        let charactersString = "?!@#$^&%*+,:;='\"`<>()[]{}/\\| "
        let allowedCharacters = NSCharacterSet(charactersIn: charactersString).inverted
        let result = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
        return result
    }
    
    
}

extension String {
    
    // 将字符串转为字典
    var toDictionary: NSDictionary? {
        
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    // 将字符串转为数组
    var toArray: NSArray? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSArray
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
//    // 转为MD5
//    func md5String() -> String {
//        
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        CC_MD5(str!, strLen, result)
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deinitialize()
//        
//        return String(format: hash as String)
//    }
    
}


extension String {
    
    // 根据固定的size和font计算文字的rect
    // - Parameters:
    // - font: 文字的字体大小
    // - size: 文字限定的宽高(计算规则:计算宽度, 传入一个实际的高度, 用于计算的宽度则取计算单位的最大值)
    func rect(withFont font: UIFont, size: CGSize) -> CGRect {
        return (self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
    }
    /// 根据固定的size和font计算文字的height
    func height(withFont font: UIFont, size: CGSize) -> CGFloat {
        return self.rect(withFont: font, size: size).height
    }
    /// 根据固定的size和font计算文字的width
    func width(withFont font: UIFont, size: CGSize) -> CGFloat {
        return self.rect(withFont: font, size: size).width
    }
    
}
