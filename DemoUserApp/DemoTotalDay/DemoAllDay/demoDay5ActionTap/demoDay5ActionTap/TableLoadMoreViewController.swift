//
//  CollectionViewController.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 2/4/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class TableLoadMoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var recoderArr: [Int] = []
    var limit = 20
    let totalEnteries = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        print(recoderArr)
        var index = 0
        while index < limit {
            recoderArr.append(index)
            index = index + 1
        }
    }
    

}

extension TableLoadMoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recoderArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell.textLabel?.text = "Row \(recoderArr[indexPath.row])"
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == recoderArr.count - 1 {
            // this is last cell
            if recoderArr.count < totalEnteries {
                // Load more
                var index = recoderArr.count
                limit = limit + 20
                while index < limit {
                    recoderArr.append(index)
                    index = index + 1
                }
                
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
//                self.tableView.reloadData()
            }
        }
    }
    
    @objc func loadTable(){
        self.tableView.reloadData()
    }


}
