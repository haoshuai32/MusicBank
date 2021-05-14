//
//  BannerSectionController.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/24.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import IGListKit

class BannerSectionController: ListSectionController {
    
    var dataSource: [BannerItemModel] = []
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        return CGSize(width: width, height: 130)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "BannerContentCell", bundle: nil, for: self, at: index) as! BannerContentCell
//        cell.backgroundColor = UIColor.orange
//        cell.contentView.backgroundColor = UIColor.orange
        return cell
    }

    override func didUpdate(to object: Any) {
//        guard let data = object as? BannerListModel else {
//            fatalError()
//        }
        dataSource = [BannerItemModel(id: 0),BannerItemModel(id: 1),BannerItemModel(id: 2)]
    }
    override func didSelectItem(at index: Int) {
        
    }
}
