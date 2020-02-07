//
//  TableViewController.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 2/3/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl?
    
    var arrVietNam: Array<Array<String>> = [["Ha Noi", "Ha Giang"],["Hue","Da Nang", "Nha Trang"],["Ho Chi Minh", "Tien Giang", "Ca Mau","Phu Quoc"]]
    var arrDetail: Array<Array<String>> = [["Pokemon A", "Pokemon B"],["Pokemon C","Pokemon D", "Pokemon E"],["Pokemon F", "Pokemon G", "Pokemon H","Pokemon J"]]
    var arrHeader: Array<String> = ["Mien Bac", "Mien Trung", "Mien Nam"]
    var arrImage: Array<Array<String>> = [["PNG001","PNG002"],["PNG003","PNG004","PNG005"],["PNG006","PNG007","PNG008","PNG009"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        addrefreshControl()
    }
    
   
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5 // number of row
        return arrVietNam[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrVietNam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // C1: khai bao đơn gian
//        let cell = tableView.dequeueReusableCell(withIdentifier:  "Cell")
//        print(arrVietNam[indexPath.section][indexPath.row])
//            cell?.textLabel?.text = arrVietNam[indexPath.section][indexPath.row]
        
        //C2: chuyen mh + show img dc chon
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomCell {
            cell.lblName.text = arrVietNam[indexPath.section][indexPath.row]
            cell.imgView.image = UIImage(named: arrImage[indexPath.section][indexPath.row])
            cell.lblDetail.text = arrDetail[indexPath.section][indexPath.row]
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImageVC") as! ImageViewController
        vc.imgName = arrImage[indexPath.section][indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        print(arrHeader)
        return self.arrHeader[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func addrefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.red
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    @objc func refreshList() {
        let i = Int.random(in: 0 ..< 3)
        arrVietNam[i].append("AAAAA")
        arrImage[i].append("Ahihi")
        arrDetail[i].append("Hello")
        
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
}
