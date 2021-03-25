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
    
    private
    lazy var adapter: ListAdapter = {
         return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: microphoneButton)
        
        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
//        collectionView.mj_header = MJRefreshNormalHeader()
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
        return [1].map{NSNumber.init(value: $0)}
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let data = object as? Int else {
            fatalError()
        }
        return ToolSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

