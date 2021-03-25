//
//  MusicBankAlbumNameCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

class MusicBankAlbumNameCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

class MusicBankAlbumNameSectionController: ListSectionController {
    
    var dataSource: Int?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 72.5)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "MusicBankAlbumNameCell", bundle: nil, for: self, at: index) as! MusicBankAlbumNameCell
        cell.titleLabel.text = "\(dataSource ?? 0)"
        return cell
    }

    override func didUpdate(to object: Any) {
        guard let data = object as? NSNumber else {
            fatalError()
        }
        self.dataSource = data.intValue
    }
    
}
