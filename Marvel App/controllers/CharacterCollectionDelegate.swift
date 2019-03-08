//
//  CharacterCollectionDelegate.swift
//  Marvel App
//
//  Created by Mina  on 3/7/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import UIKit

class CharacterCollectionDelegate : NSObject, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var items = [Item]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCollectionCell", for: indexPath) as! CharacterCollectionViewCell
        cellCollection.item = self.items[indexPath.item]
        cellCollection.setviews()
        return cellCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 150.0)
    }
}
