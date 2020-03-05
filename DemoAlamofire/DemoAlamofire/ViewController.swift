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

    @IBOutlet weak var  txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tbvAlbum: UITableView!
//    var BASE_URL = "http://gateway.marvel.com/v1/public/comics?ts=1&apikey=d8cc630e6d847e0c8358c512f1778f06&hash=a6f2f6b0dc7b053ec92bcd6a7988b62a"
    
//    var albumDatas = [Album]()
    var arrShowItem: [Audio] = [Audio]()
    var index = 0
    var limit = 10
    var skip = 0
    var isLoading = false
    var isNoLoadMore = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvAlbum.delegate = self
        tbvAlbum.dataSource = self
        
        postComicsData(["limit": limit, "orderBy": "title"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
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
    
    func postComicsData(_ param: [String: Any]) {
        guard let url = URL(string: Production.BASE_URL) else {
            print("GET URL ERROR")
            return
        }
        Alamofire.request(url, method: .get, parameters: param, headers: nil).responseJSON {[weak self] (response) in
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
            
            if dataResultsObj.count == 0  {
                self.isNoLoadMore = true
            }
            
            for item:[String : Any] in dataResultsObj {
                let audio = Audio(dic: item)
                DBManager.shared.insterAudio(audio: audio)
                arrShowItem.append(audio)
            }
            isLoading = false
            
            txtSearch.text = nil
            
            // reload Data
            tbvAlbum.reloadData()
            
        case .failure(let error):
            print("ERROR FROM SERVER: \(error) ")
        }
    }
    
    @IBAction func searchComicsActionClick(_ sender: Any) {
        if let textSearch = txtSearch.text, !textSearch.isEmpty {
            print("Title: \(textSearch)")
            postComicsData(["title": textSearch, "limit": limit, "orderBy": "title"])
        } else {
            postComicsData(["limit": limit, "orderBy": "title"])
        }
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight =  view.frame.height
        if !isLoading && !isNoLoadMore && roundf(Float(contentHeight - frameHeight - offsetY))  < 44.0 {
            // load more data
            isLoading = true
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        index += 1
        skip = limit * index
        let param = ["limit": limit, "orderBy": "title", "offset": skip] as [String : Any]
        self.postComicsData(param)
        
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrShowItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tbvAlbum.dequeueReusableCell(withIdentifier: "Cell") as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        
        cell.fillData(arrShowItem[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CuongTT: \(arrShowItem[indexPath.row])")
        
        let rowItem = arrShowItem[indexPath.row]
       
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        vc.audio = rowItem
        navigationController?.pushViewController(vc, animated: true)
    }
}
