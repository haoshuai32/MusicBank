//
//  SelectDateSectionController.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/24.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import IGListKit

class SelectDateSectionController: ListSectionController {
    
    private var dataSource: [NSNumber] = []
    
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
        return CGSize(width: collectionContext!.containerSize.width, height: 41)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "SelectDateCell", bundle: nil, for: self, at: index) as? SelectDateCell else {
            fatalError()
        }
        adapter.collectionView = cell.collectionView
        return cell
    }
     
    // --  ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return dataSource
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return DateSectionController()
    }
    
    override func didUpdate(to object: Any) {
//        guard let data = object as? DateListModel else {
//            fatalError()
//        }
        var list = [NSNumber]()
        for i in 0..<14 {
            list.append(NSNumber(value: i))
        }
        self.dataSource = list
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
    
    
}

extension SelectDateSectionController: ListAdapterDataSource {
    
}
