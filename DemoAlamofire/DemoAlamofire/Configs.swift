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
    static let BASE_URL:String = "http://gateway.marvel.com/v1/public/comics?ts=1&apikey=d8cc630e6d847e0c8358c512f1778f06&hash=a6f2f6b0dc7b053ec92bcd6a7988b62a"
}

// xac dinh loai ERROR
enum NetworkErrorType {
    case API_ERROR
    case HTTP_ERROR
}
