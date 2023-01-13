//
//  MusicBankSearchResultViewController.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/25.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

class MusicBankSearchResultItemVCModel: ListDiffable {
    
    let dataSource: MusicBankViewController
    
    let keyword: String?
    
    init(text: String, vc: MusicBankViewController) {
        self.keyword = text
        self.dataSource = vc
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return dataSource
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if object === self { return true }
        return false
//        guard let vc = object as? Self else {
//            assert(false)
//            return false
//        }
//        if vc.dataSource == self.dataSource {
//            return true
//        }
//        else {
//            return false
//        }
    }
    
}

protocol MusicBankSearchListViewController: MusicBankViewController {
    var keyword: String? {set get}
    var adapter: ListAdapter{get}
    var collectionView:ListCollectionView! {get}
    var pageIndex: Int {set get}
    var pageSize: Int { get }
    /// 数据
    var dataSource: [ListDiffable] {set get}
    /// 加载状态
    var loading: Bool {set get}
    /// 刷新动画
    var reloadToken: String {get}
    /// 加载更多动画
    var loadMoreToken: String {get}
    
    func bing()
    func reload()
    func loadMore()
}

extension MusicBankSearchListViewController {
    func bing() {
        
        NotificationCenter.default.rx
            .notification(Notification.Name.Search.Keyword)
            .subscribe(onNext: { [weak self] (noti) in
                guard let keyword = noti.object as? String else {
                    return
                }
                self?.keyword = keyword
                self?.reload()
            })
            .disposed(by: self.disposeBag)
        
    }
    
    func reload() {
        fatalError()
    }
    
    func loadMore(){
        fatalError()
    }
}


class MusicBankSearchResultViewController:MusicBankViewController,
                                          ListAdapterDataSource
{

    @IBOutlet weak var collectionView:ListCollectionView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    private var dataSource: [MusicBankSearchResultItemVCModel] = []
    
    private
    lazy var adapter: ListAdapter = {
         return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.navigationItem.titleView = searchBar
        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        adapter.collectionView = collectionView
        adapter.dataSource = self
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
