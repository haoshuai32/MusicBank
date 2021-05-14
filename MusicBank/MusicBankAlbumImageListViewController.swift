//
//  MusicBankAlbumImageListViewController.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/25.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

class MusicBankAlbumImageListViewController: MusicBankViewController {

    @IBOutlet weak var collectionView:ListCollectionView!
    
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
extension MusicBankAlbumImageListViewController:ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return (1..<20).map{NSNumber.init(value: $0)}
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return MusicBankAlbumImageSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
