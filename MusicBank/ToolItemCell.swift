//
//  ToolItemCollectionViewCell.swift
//  MusicBank
//
//  Created by flqy on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit

class ToolItemCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override var isSelected: Bool {
        set {
            
            if newValue {
                self.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
            } else {
                self.transform = CGAffineTransform.identity
            }
            
            super.isSelected = newValue
        }
        get {
            return super.isSelected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
