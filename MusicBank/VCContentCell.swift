//
//  VCContentCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/24.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit
class VCModel: ListDiffable {
    
    let vc: UIViewController
    
    let id: Int
    
    init(id: Int,vc: UIViewController) {
        self.id = id
        self.vc = vc
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? VCModel  else {
            return false
        }
        return data.id == self.id
    }
}

class VCContentCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: ListCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        // Initialization code
    }

}
