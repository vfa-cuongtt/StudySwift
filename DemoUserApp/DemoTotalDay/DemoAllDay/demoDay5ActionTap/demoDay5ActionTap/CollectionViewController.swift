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
     var arrImage: Array<String> = ["PNG001","PNG002", "PNG003","PNG004", "PNG005", "PNG006","PNG007","PNG008","PNG009"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionCell.delegate = self
        collectionCell.dataSource = self
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.green
        print(indexPath.section)
        cell.imgView.image =  UIImage(named: arrImage[indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        print(indexPath.section)
        let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionImageVC") as! CollectionImageViewCell
        vc.imgName = arrImage[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
