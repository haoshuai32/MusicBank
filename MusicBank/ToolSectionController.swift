//
//  ToolSectionController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import IGListKit

class ToolItemModel: ListDiffable {
    
    var id: Int = 0
    var name: String = ""
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ToolItemModel else {
            return false
        }
        return object.id == self.id
    }
    
}

class ToolSectionController: ListSectionController {
    
    private var number:Int?
    
    private var bottomLineView: UIView?

    
    private
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    override func numberOfItems() -> Int {
        return 1
    }

    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 120)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ToolCell", bundle: nil, for: self, at: index) as? ToolCell else {
            fatalError()
        }
        
        adapter.collectionView = cell.colleciontView
        bottomLineView = cell.bottomLineView
        return cell
    }
    
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return (0...20).map{NSNumber.init(value: $0)}
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sc = ToolItemSectionController()
        sc.de = self
        return sc
    }
    
    override func didUpdate(to object: Any) {
        number = object as? Int
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
    
    var selectIndex = 0
    func toolItemDidSelectItem(at index: Int) {
        selectIndex = index
        let x = index * 61
//        UIView.animate(withDuration: 0.25) {
//            self.bottomLineView?.frame = CGRect(x: x, y: 0, width: 61, height: 5)
//        }
    }
    
}

extension ToolSectionController: ListAdapterDataSource,ToolItemSectionControllerDe {

}
