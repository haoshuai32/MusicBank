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

class BannerContentCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
