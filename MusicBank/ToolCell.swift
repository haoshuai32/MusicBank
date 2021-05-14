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
        
        let  threadPort = NSMachPort.init(machPort: 1)
        threadPort.send(before: <#T##Date#>, components: <#T##NSMutableArray?#>, from: <#T##Port?#>, reserved: <#T##Int#>)
        
        // Initialization code
    }

}
