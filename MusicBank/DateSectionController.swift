//
//  DateSectionController.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/24.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import IGListKit

class DateSectionController: ListSectionController {
    
    var dataSource: NSNumber?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 76, height: 41)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "DateCell", bundle: nil, for: self, at: index) as! DateCell
//        let date = self.dataSource?.date
        cell.timeLabel.text = "\(dataSource ?? 0)"
        return cell
    }

    override func didUpdate(to object: Any) {
        guard let data = object as? NSNumber else {
            fatalError()
        }
        dataSource = data
    }
    
}
