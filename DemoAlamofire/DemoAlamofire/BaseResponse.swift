//
//  BaseResponse.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 2/21/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseReponse<T: Mappable>: Mappable {
    var status: String?
    var code: Int?
    var message: String?
    var data: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
    
    func isSuccessCode() -> Bool {
        return code == 200
    }
}

class BaseReponseError {
    var mErrorType: NetworkErrorType!
    var mErrorCode: Int!
    var mErrorMessage: String!
    
    init(_ errorType: NetworkErrorType, _ errorCode: Int, _ errorMessage: String) {
        
        mErrorCode = errorCode
        mErrorType = errorType
        mErrorMessage = errorMessage
    }
}
