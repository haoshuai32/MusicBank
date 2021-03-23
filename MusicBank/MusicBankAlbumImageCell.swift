//
//  MusicBankAlbumImageCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit

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
