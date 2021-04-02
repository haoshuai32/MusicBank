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
    
    let id: Int
    let text: String
    init(id: Int, text: String) {
        self.id = id
        self.text = text
    }
}

class MusicBankSearchViewController: MusicBankViewController,UIScrollViewDelegate {

    @IBOutlet weak var collectionView:ListCollectionView!
    
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


