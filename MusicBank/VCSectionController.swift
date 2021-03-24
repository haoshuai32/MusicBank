//
//  VCSectionController.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/24.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import IGListKit

class VCSectionController: ListSectionController {
    
    var dataSource: UIViewController?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let height:CGFloat = 635.0
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "VCViewCell", bundle: nil, for: self, at: index) as! VCViewCell
        guard let view = dataSource?.view else {
            fatalError()
        }
        let height:CGFloat = 635.0
        view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: height))
        cell.addSubview(view)
        return cell
    }

    override func didUpdate(to object: Any) {
        guard let data = object as? VCModel else {
            fatalError()
        }
        dataSource = data.vc
    }
    
}
