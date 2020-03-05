//
//  ModelData.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 2/28/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation

struct Audio {
    var description: String?
    var title: String?
    var thumbnail: Thumbnail?
    
    init(dic: [String : Any]) {
        if let description = dic["description"] as? String {
            self.description = description
        }
        
        if let title = dic["title"] as? String {
            self.title = title
        }
        
        if let item = dic["thumbnail"] as? [String : Any] {
            self.thumbnail = Thumbnail(dic: item)
        }
    }
}

struct Prices {
    var type: String?
    var price: Double = 0.0
    
    init(dic: [String : Any]) {
        if let type = dic["type"] as? String {
            self.type = type
        }
        if let price = dic["price"] as? Double {
            self.price = price
        }
    }
}

struct Thumbnail {
//    var path: String?
//    var extent: String?
    
    var url: String?
    
    init(dic: [String : Any]) {
//        if let path = dic["path"] as? String {
//            self.path = path
//        }
//        if let extent = dic["extension"] as? String {
//            self.extent = extent
//        }

        if let path = dic["path"]! as? String , let extent = dic["extension"]! as? String{
            self.url = "\(path)/portrait_xlarge.\(extent)"
        }
    }
}
