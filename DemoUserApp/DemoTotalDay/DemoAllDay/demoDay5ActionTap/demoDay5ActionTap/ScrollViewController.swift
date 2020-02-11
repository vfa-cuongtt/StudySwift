//
//  ScrollViewController.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 2/11/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

//    fileprivate let scrollView:UIScrollView = {
//        let scroll = UIScrollView()
//        scroll.translatesAutoresizingMaskIntoConstraints = false
//
//        return scroll
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //B1: create auto layout
        let scrollView:UIScrollView = UIScrollView()
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        scrollView.isPagingEnabled = true
        
        
        //B2: create Item in scroll view
        // Create First View
         let firstView = UIView()
        firstView.backgroundColor = UIColor.green
        scrollView.addSubview(firstView)
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        firstView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        firstView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        firstView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        
        //B3: add width height
        firstView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        firstView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        //B4: Create second View
        let secondView = UIView()
        secondView.backgroundColor = UIColor.red
        scrollView.addSubview(secondView)
        secondView.translatesAutoresizingMaskIntoConstraints = false
        secondView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        secondView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        secondView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        secondView.leftAnchor.constraint(equalTo: firstView.rightAnchor).isActive = true
        
        //B5: add width & height
        secondView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        secondView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    



}
