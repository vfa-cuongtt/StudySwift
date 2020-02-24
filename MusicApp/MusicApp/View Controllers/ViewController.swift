//
//  ViewController.swift
//  MusicApp
//
//  Created by Tuan Cuong on 2/18/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        print("test")
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        cell.lblArtist.text = "AAAA"
        cell.lblTitle.text = "BBB"
        return cell
    }


}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let textSearch = searchBar.text, !textSearch.isEmpty else {
            print("is empty")
            return
        }
        print(textSearch)
    }
}
