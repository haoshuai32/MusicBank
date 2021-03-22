//
//  ToolCollectionViewCell.swift
//  MusicBank
//
//  Created by flqy on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

class ToolCell: UICollectionViewCell {

    @IBOutlet weak var colleciontView: ListCollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        colleciontView.setCollectionViewLayout(layout, animated: false)
        // Initialization code
    }

}
