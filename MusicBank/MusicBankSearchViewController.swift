//
//  MusicBankSearchViewController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/13.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift
import RxCocoa
<<<<<<< HEAD

class NumberText: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? NumberText  else {
            return false
        }
        return self.id == data.id
    }
=======

class MusicBankSearchViewController: MusicBankViewController {

    @IBOutlet weak var collectionView:ListCollectionView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    private
    lazy var adapter: ListAdapter = {
         return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    var childCanScroll = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = searchBar
        
        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
    }
    
>>>>>>> d7295c5c041c57d5811f8b41d697edbb93d70268
    
    let id: Int
    let text: String
    init(id: Int, text: String) {
        self.id = id
        self.text = text
    }
}

class MusicBankSearchViewController: MusicBankViewController,UIScrollViewDelegate {

    @IBOutlet weak var collectionView:ListCollectionView!
    
<<<<<<< HEAD
//    lazy var dataSource: [NumberText] = {
//        let data = (0...30).map{NumberText(id: $0, text: "我是文本\($0)")}
//        return data
//    }()
//
//    private
//    lazy var adapter: ListAdapter = {
//         return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
//    }()
//    var childCanScroll = false
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        debugPrint("重写创建")
//        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
//        adapter.collectionView = collectionView
//        adapter.dataSource = self
//    }
    
=======
>>>>>>> d7295c5c041c57d5811f8b41d697edbb93d70268
}


// MARK: ListAdapterDataSource
//extension MusicBankSearchViewController:ListAdapterDataSource {
//    
//    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
//        return dataSource
//    }
//
//    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
//        return ToolItemSectionController()
//    }
//
//    func emptyView(for listAdapter: ListAdapter) -> UIView? {
//        return nil
//    }
//    
//    
//}


