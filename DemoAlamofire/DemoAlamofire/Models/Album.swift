//
//  Album.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 2/24/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation

final class Album {
    var title = ""
    var description = ""
    var thumbnail = ""
    
    init(data: [String: Any]) {
        if let title = data["title"] as? String {
            self.title = title
        }
        
        if let series = data["description"] as? String {
            self.description = series
        }
        
        if let thumbnail = data["thumbnail"] as? String {
            print(thumbnail)
            self.thumbnail = thumbnail
        }
    }
}
