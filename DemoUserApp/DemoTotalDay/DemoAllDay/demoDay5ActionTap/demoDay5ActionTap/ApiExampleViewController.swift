//
//  ApiExampleViewController.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 2/12/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

//dummy JSon
//{
//    "id": 1,
//    "name": "Descript 1",
//    "description": "kajsaskdjadllkx mxcvaksjdas,mx kslaflksdfkj",
//    "course": [
//    {
    //    "id": 1,
    //    "name": "a1",
    //    "detail": "Hello"
//    },
//    {
    //    "id": 2,
    //    "name": "a2",
    //    "detail": "How are you"
    //    },
//    {
//        "id": 3
//    }
//  ]
//}


struct WebDescription: Decodable {
    let id: Int
    let name: String
    let description: String
    let course: [Course]
}

struct Course:Decodable  {
    let id: Int?
    let name: String?
    let detail: String?
    
     // Swift 3/2/Object-C
//    init(json: [String:Any]) {
//        id = json["id"] as? Int ?? -1
//        name = json["name"] as? String ?? ""
//        detail = json["detail"] as? String ?? ""
//    }
}


class ApiExampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Call API ")
        
        let jsonUrlString = "https://api.myjson.com/bins/vueyk"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, respont, err) in
            // check er
            // respont status == 200 is OK
            guard let data = data else {return}
            
            // return veef dang String
//            let dataString = String(data: data, encoding: .utf8)
//            print(dataString)
            
            do{
                
                //Swift 4, 5
                // get data json in Course
//              let course = try JSONDecoder().decode([Course].self, from: data)
                
                
                let webDescription = try JSONDecoder().decode(WebDescription.self, from: data)
                print(webDescription.course)
                
    
                // Swift 3/2/Object-C
                // return ve Json Object
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
//                let course = Course(json: json)
                
//                print(course)
                
            }catch let jsonErr {
                print(jsonErr)
            }
            
        }.resume()
    }
    

}
