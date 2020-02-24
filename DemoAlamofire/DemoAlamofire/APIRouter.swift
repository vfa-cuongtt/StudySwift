//
//  APIRouter.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 2/20/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    // khai bao API
    case login(email: String, passwork: String)
    case changePassword(pass: String, newPass: String, confirmNewPass: String)
    case getUserData
    
    // HTTP method request
    private var method: HTTPMethod {
        switch self {
        case .login, .changePassword:
            return .post
        case .getUserData:
            return .get
        default:
            break
        }
        
    }
    
    // API Path
    private var path:String {
        switch self {
        case .login:
            return "Path cua API"
        case .changePassword:
            return "Path cua API"
        case .getUserData:
            return "Path cua API"
        default:
            break
        }
    }
    
    // Request Header
    private var headers: HTTPHeaders {
        var headers = ["Accept": "application/json"]
        switch self {
        case .login:
            break
        case .changePassword:
            headers["Authorization"] = getAuthorization()
            break
        default:
            break
        }
        
        return headers;
    }
    
    // Request Parameter
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [
                "email" : email,
                "password" : password
            ]
            
        case .changePassword(let pass, let newPass, let confirmNewPass):
            return [
                "password": pass,
                "new_password": newPass,
                "confirm_new_password": confirmNewPass
            ]
        case .getUserData:
            <#code#>
        }
    }
    // Url Request
    func asURLRequest() throws -> URLRequest {
        // get url tai file Production
        let url = try Production.BASE_URL.asURL()
        
        // setting path
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // setting method
        urlRequest.httpMethod =  method.rawValue
        
        //setting header
        for(key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                print("Encoding fail")
            }
        }
        
        return urlRequest
    }
    
    //
    private func getAuthorization() -> String? {
        return "Authorization token"
    }
}
