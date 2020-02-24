//
//  Track.swift
//  MusicApp
//
//  Created by Tuan Cuong on 2/19/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation

class Track{
    let artist: String
    let index: Int
    let name: String
    let previewURL: URL
    
    init(name: String, artist: String, index: Int, previewURL: URL) {
        self.name = name
        self.artist = artist
        self.index = index
        self.previewURL = previewURL
    }
}
