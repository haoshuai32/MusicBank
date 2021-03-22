//
//  ToolItemListSectionController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import IGListKit

class ToolItemSectionController: ListSectionController {
    
    private var number: Int?
    
    
    override func numberOfItems() -> Int {
        if number == 1 {
            return 1
        }
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let height = collectionContext?.containerSize.height ?? 0
        return CGSize(width: height, height: height)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "ToolItemCell", bundle: nil, for: self, at: index) as! ToolItemCell
        let value = number ?? 0 + index
        cell.nameLabel.text = "\(value + 1)"
        return cell
    }

    override func didUpdate(to object: Any) {
        number = object as? Int
        debugPrint("我的数据",number)
    }
}
