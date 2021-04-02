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
    
    func bindViewModel(_ viewModel: Any) {
        guard let data = viewModel as? NumberText else {
            assert(false)
            return
        }
        debugPrint("绑定数据模型",data.text)
        self.nameLabel.text = data.text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
