//
//  ToolItemListSectionController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import IGListKit


protocol ToolItemSectionControllerDe {
    func toolItemDidSelectItem(at index: Int)
}

class ToolItemSectionController: ListSectionController {
    
    private var number: Int?
    
    override init() {
        super.init()
        
        
    }
    
    var de: ToolItemSectionControllerDe?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: kItemWidth, height: kItemWidth)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "ToolItemCell", bundle: nil, for: self, at: index) as! ToolItemCell
        let value = number ?? 0 + index
        cell.nameLabel.text = "\(value + 1)"
        return cell
    }

    override func didUpdate(to object: Any) {
        number = object as? Int
    }
    
    
    override func didSelectItem(at index: Int) {
        debugPrint("选中",index)
        de?.toolItemDidSelectItem(at: number!)
//        if index == selectIndex {
//            return
//        }
//
        

        
        
    }
}
