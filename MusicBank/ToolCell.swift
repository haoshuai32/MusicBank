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
    
    
    lazy var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        colleciontView.setCollectionViewLayout(layout, animated: false)
        bottomLineView.frame = CGRect(x: 0, y: 0, width: 61, height: 5)
        self.colleciontView.addSubview(bottomLineView)
        // Initialization code
    }
    
    

}
