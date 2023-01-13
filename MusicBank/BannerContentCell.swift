//
//  BannerContentCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/24.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

class BannerItemModel: ListDiffable {
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? SongModel  else {
            return false
        }
        return data.id == self.id
    }
    
}


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


class BannerContentCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
