//
//  MusicBankAlbumImageCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

class MusicBankAlbumImageCell: UICollectionViewCell {

    @IBOutlet weak var imaegView: UIImageView!
    
    @IBOutlet weak var introductionLabel: UILabel!

    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var playImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


class MusicBankAlbumImageSectionController: ListSectionController {
    
    var dataSource: Int?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 72.5)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "MusicBankAlbumImageCell", bundle: nil, for: self, at: index) as! MusicBankAlbumImageCell
        return cell
    }

    override func didUpdate(to object: Any) {
        guard let data = object as? NSNumber else {
            fatalError()
        }
        self.dataSource = data.intValue
    }
    
    
}
