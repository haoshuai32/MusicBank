//
//  SelectDateCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/24.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

class DateItemModel: ListDiffable {
    
    let id: Int
    let date: Date
    init(id: Int) {
        self.id = id
        self.date = Date().addingTimeInterval(TimeInterval(id * 24 * 60 * 60))
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? DateItemModel  else {
            return false
        }
        return data.id == self.id
    }
}

class SelectDateCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: ListCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        // Initialization code
    }

}
