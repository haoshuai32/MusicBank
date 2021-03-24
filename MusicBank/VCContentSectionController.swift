//
//  VCContentSectionController.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/24.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import IGListKit



class VCContentSectionController: ListSectionController {
    
    private var dataSource: [VCModel] = []
    
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
        let height:CGFloat = 635.0
        return CGSize(width: collectionContext!.containerSize.width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "VCContentCell", bundle: nil, for: self, at: index) as? VCContentCell else {
            fatalError()
        }
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return dataSource
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return VCSectionController()
    }
    
    let vc0 = VCModel(id: 0, vc: UIStoryboard.Find.instantiate(MusicBankSearchViewController.self))
    let vc1 = VCModel(id: 1, vc: UIStoryboard.Main.instantiate(MusicBankPlayerViewController.self))
    override func didUpdate(to object: Any) {
//        guard let data = object as? VCListModel else {
//            fatalError()
//        }
        var list = [VCModel]()
        

        list = [vc0,vc1]
        for item in list {
            self.viewController?.addChild(item.vc)
        }
        
        self.dataSource = list
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
    
    
}

extension VCContentSectionController: ListAdapterDataSource {
    
}
