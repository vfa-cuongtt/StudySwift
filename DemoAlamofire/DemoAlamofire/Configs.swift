//
//  Configs.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 2/20/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation

// khoi tao 1 BASE_URL
struct Production {
//    static let BASE_URL:String = "http://api.letsbuildthatapp.com/jsondecodable/course"
//    static let BASE_URL:String = "http://localhost:8080/testSource/testApi.php"
    static let BASE_URL:String = "https://gateway.marvel.com/v1/public/comics?apikey=d8cc630e6d847e0c8358c512f1778f06"
}

// xac dinh loai ERROR
enum NetworkErrorType {
    case API_ERROR
    case HTTP_ERROR
}
