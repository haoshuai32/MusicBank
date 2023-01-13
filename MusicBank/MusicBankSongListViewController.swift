//
//  MusicBankSongListViewController.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/25.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift

class MusicBankSongListViewController: MusicBankViewController,
                                       ListAdapterDataSource,
                                       MusicBankSearchListViewController {
    var loading: Bool = false
    
    let reloadToken: String = "reload"
    
    let loadMoreToken: String = "loadMore"
    
    var keyword: String?
    
    var pageIndex: Int = 0
    
    let pageSize: Int = 20
    
    var dataSource: [ListDiffable] = []
    

    @IBOutlet weak var collectionView:ListCollectionView!
    
    
    lazy var adapter: ListAdapter = {
         return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bing()
        
        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
    }
    
    
    func reload() {
        
    }
    
    func loadMore() {
        
    }
    
    // MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return (1..<20).map{NSNumber.init(value: $0)}
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return MusicBankSongSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

