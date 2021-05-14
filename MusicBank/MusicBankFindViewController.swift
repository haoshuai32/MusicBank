//
//  MusicBankFindViewController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/13.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit
import MJRefresh

class MusicBankFindViewController: MusicBankViewController {

    @IBOutlet weak var collectionView: ListCollectionView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var microphoneButton: UIButton!
    
    var dataSource: [NumberText] = []

    
    private
    lazy var adapter: ListAdapter = {
         return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    var childCanScroll = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< HEAD
        dataSource = (0...30).map{NumberText(id: $0, text: "我是文本\($0)")}
=======
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: microphoneButton)
>>>>>>> d7295c5c041c57d5811f8b41d697edbb93d70268
        
        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        adapter.collectionView = collectionView
        adapter.dataSource = self
<<<<<<< HEAD
=======
        
//        collectionView.mj_header = MJRefreshNormalHeader()
>>>>>>> d7295c5c041c57d5811f8b41d697edbb93d70268
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        let vc = UIStoryboard.Main.instantiate(MusicBankPlayerViewController.self)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

// MARK: ListAdapterDataSource
extension MusicBankFindViewController:ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
<<<<<<< HEAD
        return dataSource
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ToolItemSectionController()
=======
        return [1].map{NSNumber.init(value: $0)}
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let data = object as? Int else {
            fatalError()
        }
        return ToolSectionController()
>>>>>>> d7295c5c041c57d5811f8b41d697edbb93d70268
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

