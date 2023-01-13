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

    var dataSource: [ListDiffable] = []
    
    @IBOutlet weak var collectionView: ListCollectionView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var microphoneButton: UIButton!
    
    lazy var adapter: ListAdapter = {
         return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let naviList = [
            MusicBankNavigationBarItemModel(name: "每日推荐", image: UIImage(named: "1")!),
            MusicBankNavigationBarItemModel(name: "私人FM", image: UIImage(named: "2")!),
            MusicBankNavigationBarItemModel(name: "歌单", image: UIImage(named: "2")!),
            MusicBankNavigationBarItemModel(name: "排行榜", image: UIImage(named: "3")!),
            MusicBankNavigationBarItemModel(name: "游戏专区", image: UIImage(named: "3")!),
            MusicBankNavigationBarItemModel(name: "歌房", image: UIImage(named: "1")!),
            MusicBankNavigationBarItemModel(name: "直播", image: UIImage(named: "1")!),
            
        ]
        let bar = MusicBankNavigationBarListModel(id: naviList.count, list: naviList)
        self.dataSource.append(bar)

        
        let songList = [
            MusicBankSongItemModel(id: 1, playCount: 23, image: UIImage(named: "3")!, name: "心如刀割", logo: false),
            MusicBankSongItemModel(id: 2, playCount: 12, image: UIImage(named: "3")!, name: "她来听我演唱会,我 听你的你说什么是什么", logo: false),
            MusicBankSongItemModel(id: 3, playCount: 31, image: UIImage(named: "3")!, name: "情书", logo: false),
            MusicBankSongItemModel(id: 4, playCount: 1, image: UIImage(named: "3")!, name: "他在哪里", logo: false),
            MusicBankSongItemModel(id: 5, playCount: 90, image: UIImage(named: "3")!, name: "情网", logo: false),
            MusicBankSongItemModel(id: 6, playCount: 100, image: UIImage(named: "3")!, name: "如果这都不算爱", logo: false),
            MusicBankSongItemModel(id: 7, playCount: 200, image: UIImage(named: "3")!, name: "慢慢", logo: false),
        ]
        
        let song = MusicBankSongListModel(list: songList)
        self.dataSource.append(song)
        
        
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: microphoneButton)
        
        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        
    }
    
}

// MARK: ListAdapterDataSource
extension MusicBankFindViewController:ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return dataSource
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is MusicBankNavigationBarListModel {
            return MusicBankNavigationSectionController()
        }
        if object is MusicBankSongListModel {
            return MusicBankSongListSectionController()
        }
        fatalError()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

