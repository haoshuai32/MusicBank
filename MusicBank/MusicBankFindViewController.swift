//
//  MusicBankFindViewController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/13.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit


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
        
        dataSource = (0...30).map{NumberText(id: $0, text: "我是文本\($0)")}
        
        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        adapter.collectionView = collectionView
        adapter.dataSource = self
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
        return dataSource
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ToolItemSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

