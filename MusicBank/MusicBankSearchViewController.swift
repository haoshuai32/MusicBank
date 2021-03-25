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
    var childCanScroll = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        
        NotificationCenter.default.rx
            .notification(Notification.Name.ScrollEnabled.Find)
            .subscribe(onNext: { (noti) in
                guard let isScrollEnabled = noti.object as? Bool else {
                    return
                }
                debugPrint("设置子视图滑动状态", isScrollEnabled)
                self.childCanScroll = isScrollEnabled
            })
            .disposed(by: disposeBag)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        debugPrint("子视图滑动", scrollView.contentOffset.y, childCanScroll)
        if !childCanScroll {
            scrollView.contentOffset.y = 0
        } else {
            if scrollView.contentOffset.y <= 0 {
                childCanScroll = false
                debugPrint("发送父试图滑动状态")
                NotificationCenter.default.post(name: NSNotification.Name.ScrollEnabled.Mine, object: true)
            }
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


