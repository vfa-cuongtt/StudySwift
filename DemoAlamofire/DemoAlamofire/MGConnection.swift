
//
//  MGConnection.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 2/21/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class MGConnection{
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func request<T: Mappable>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: T?, _ error: BaseReponseError?) -> Void) {
        if !isConnectedToInternet() {
            // xu ly  loi ket noi Internet
            return
        }
        
        
    }
    
}
