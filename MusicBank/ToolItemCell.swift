//
//  ToolItemCollectionViewCell.swift
//  MusicBank
//
//  Created by flqy on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit
class ToolItemCell: UICollectionViewCell,ListBindable {

    @IBOutlet weak var nameLabel: UILabel!
    
<<<<<<< HEAD
    func bindViewModel(_ viewModel: Any) {
        guard let data = viewModel as? NumberText else {
            assert(false)
            return
        }
        debugPrint("绑定数据模型",data.text)
        self.nameLabel.text = data.text
=======
    
    
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
>>>>>>> d7295c5c041c57d5811f8b41d697edbb93d70268
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
