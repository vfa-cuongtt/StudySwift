//
//  ViewController.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 2/19/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tbvAlbum: UITableView!
//    var BASE_URL = "http://gateway.marvel.com/v1/public/comics?ts=1&apikey=d8cc630e6d847e0c8358c512f1778f06&hash=a6f2f6b0dc7b053ec92bcd6a7988b62a"
    
    var albumDatas = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvAlbum.delegate = self
        tbvAlbum.dataSource = self
        
        getComicsData()
    }
    
    func getComicsData() {
        guard let url = URL(string: Production.BASE_URL) else {
            print("GET URL ERROR")
            return
        }
        Alamofire.request( url).responseJSON {[weak self] (response) in
            
            self?.handleParseData(response)
        }
    }

    func handleParseData(_ data: DataResponse<Any>) {
        switch data.result {
        case .success(let value):
            guard let data = value as? [String: Any],
                let dataObj = data["data"] as? [String: Any], let dataResultsObj = dataObj["results"] as? [[String: Any]] else {
                    print("Oi Dinh Menh CUoc Doi")
                    return
            }
                print("Qua rồi anh em oi ")
            print("Ahihi: \(dataObj)")
            
            albumDatas.removeAll()
            dataResultsObj.forEach{ (dataResultsObj) in
                albumDatas.append(Album(data: dataResultsObj))
                
            }
            
            // reload Data
            tbvAlbum.reloadData()
            
        case .failure(let error):
            print("ERROR FROM SERVER: \(error) ")
        }
    }
    
    @IBAction func searchComicsActionClick(_ sender: Any) {
        
    }
     
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albumDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tbvAlbum.dequeueReusableCell(withIdentifier: "Cell") as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        
       cell.fillData(albumDatas[indexPath.row])
        
        return cell
    }
    
    
}
