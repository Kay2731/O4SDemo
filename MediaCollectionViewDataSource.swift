//
//  MediaCollectionViewDataSource.swift
//  O4S
//
//  Created by Keertika on 07/02/21.
//  Copyright © 2021 keertika. All rights reserved.
//

import Foundation
import UIKit


class MediaCollectionViewDataSource<CELL:MediaCell,T:MediaFile>:NSObject,UICollectionViewDataSource{
    private var cellIdentifier:String!
    private var items:[T]!
    var configureCell: (CELL,T) ->() = {_,_ in}
    
    
    init(cellIdentifier : String, items : [T],session:URLSession,configureCell:@escaping (CELL,T) ->() ) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        let item = self.items[indexPath.row]
        self.configureCell(cell,item)
        return cell
    }
    
    
}
