//
//  CollectionViewController.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 2/6/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    
    @IBOutlet weak var collectionCell: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionCell.delegate = self
        collectionCell.dataSource = self
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.green
        return cell
    }
    
    
}
