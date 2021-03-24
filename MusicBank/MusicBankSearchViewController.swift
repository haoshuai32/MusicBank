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
class MusicBankSearchViewController: MusicBankViewController,UIScrollViewDelegate {

    @IBOutlet weak var collectionView:ListCollectionView!
    
    private
    lazy var adapter: ListAdapter = {
         return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isScrollEnabled = false
        
        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        
        NotificationCenter.default.rx
            .notification(Notification.Name.ScrollEnabled.Find)
            .subscribe(onNext: { (_) in
                self.collectionView.isScrollEnabled = true
            })
            .disposed(by: disposeBag)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0.0 {
            self.collectionView.isScrollEnabled = false
            NotificationCenter.default.post(name: NSNotification.Name.ScrollEnabled.Mine, object: nil)
            
        }
    }
    
}


// MARK: ListAdapterDataSource
extension MusicBankSearchViewController:ListAdapterDataSource {
    
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


