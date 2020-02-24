//
//  QueryService.swift
//  MusicApp
//
//  Created by Tuan Cuong on 2/19/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation

class QueryService {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errMessage = ""
    var tracks: [Track] = []
    
    typealias QueryResult  = ([Track]?, String) -> Void
    
    func getSearchRequest( searchTearm: String, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search"){
             urlComponents.query = "media=music&entity=song&term=\(searchTearm)"
            
            guard let url = urlComponents.url else {
                return
            }
            
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                
                if let error = error {
                    self?.errMessage += "DataTask error" + error.localizedDescription + "\n"
                } 
            }
        }
    }
}
