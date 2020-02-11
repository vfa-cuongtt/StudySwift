//
//  HomeViewController.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 1/20/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func UITapActionClick(_ sender: Any) {
        print("Tesst")
        let uiTapView = storyboard?.instantiateViewController(withIdentifier: "UITapView") as! ViewController
        navigationController?.pushViewController(uiTapView, animated: true)
    }
    
    @IBAction func pinchActionClick(_ sender: Any) {
        // TODO: get data from API
        let vc = storyboard?.instantiateViewController(withIdentifier: "PinchVC") as! PinchViewController
        vc.data = ["name", "email"]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func rotationActionClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RotationVC") as! RotationViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func swiperActionClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SwpieVC") as! SwipeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showTableViewActionClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TableVC") as! TableViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showLoadMoreTableViewActionClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TableLoadMoreVC") as! TableLoadMoreViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showCollectionViewActionClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionVC")  as! CollectionViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showCollectionSliderViewActionClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionSliderVC") as! CollectionSliderViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showScrollViewActionClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ScrollVC") as! ScrollViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
