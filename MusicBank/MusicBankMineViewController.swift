//
//  MusicBankMineViewController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/13.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit


class MusicBankMineViewController: MusicBankViewController {

    @IBOutlet weak var collectionView: ListCollectionView!
    
    
    private
    lazy var adapter: ListAdapter = {
         return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        
        

    }
    
    
}



// MARK: ListAdapterDataSource
extension MusicBankMineViewController:ListAdapterDataSource,UIScrollViewDelegate {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        return [1,2,3].map{NSNumber(value: $0)}  //
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let index = object as? Int else {
            fatalError()
        }

        fatalError()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}


class BannerListModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? BannerListModel else {
            return false
        }
        return data.id == self.id
    }
    
    let id: Int = 0
    var list = [BannerItemModel(id: 0),BannerItemModel(id: 1)]
    
}
