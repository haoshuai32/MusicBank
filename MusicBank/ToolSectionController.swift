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
        return CGSize(width: collectionContext!.containerSize.width, height: 88)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ToolCell", bundle: nil, for: self, at: index) as? ToolCell else {
            fatalError()
        }
        adapter.collectionView = cell.colleciontView
        return cell
    }
    
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if number == 1 {
            return [0,2,3,4,5,6,7,8,9].map{NSNumber.init(value: $0)}
        }
        return [10].map{NSNumber.init(value: $0)}
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ToolItemSectionController()
    }
    
    override func didUpdate(to object: Any) {
        debugPrint("数据刷新",object)
        number = object as? Int
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
    
    
}

extension ToolSectionController: ListAdapterDataSource {
    
    
    
}
