//
//  MusicBankMineViewController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/13.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

class MusicBankMineViewController: MusicBankViewController {

    @IBOutlet weak var collectionView: ListCollectionView!
    
    private
    lazy var adapter: ListAdapter = {
         return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        
        self.collectionView.isScrollEnabled = false
//
//        NotificationCenter.default.rx
//            .notification(Notification.Name.ScrollEnabled.Mine)
//            .subscribe(onNext: { (_) in
//                self.collectionView.isScrollEnabled = true
//            })
//            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self.view)
        debugPrint("滑动的位置", point)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}



// MARK: ListAdapterDataSource
extension MusicBankMineViewController:ListAdapterDataSource,UIScrollViewDelegate {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        return [1,2,3].map{NSNumber(value: $0)}  //
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let index = object as? Int else {
            fatalError()
        }
        if index == 1 {
            return BannerSectionController()
        }
        if index == 2 {
            return SelectDateSectionController()
        }
        if index == 3 {
            return VCContentSectionController()
        }
        fatalError()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        debugPrint("主视图滑动的距离",scrollView.contentOffset)
        if scrollView.contentOffset.y >= 171.0 {
            self.collectionView.isScrollEnabled = false
            NotificationCenter.default.post(name: NSNotification.Name.ScrollEnabled.Find, object: nil)
        }
    }
    
}


class BannerListModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? BannerListModel else {
            return false
        }
        return data.id == self.id
    }
    
    let id: Int = 0
    var list = [BannerItemModel(id: 0),BannerItemModel(id: 1)]
    
}

class DateListModel: ListDiffable {
    
    let id: Int = 1
    
    let list: [DateItemModel]
    
    init() {
        var list = [DateItemModel]()
        for i in 0..<14 {
            list.append(DateItemModel(id: i))
        }
        self.list = list
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? DateListModel else {
            return false
        }
        return data.id == self.id
    }
    
    
}

class VCListModel: ListDiffable {
    let id: Int = 3
    let list: [VCModel]
    init() {
        let vc0 = VCModel(id: 0, vc: MusicBankSearchViewController())
        let vc1 = VCModel(id: 1, vc: MusicBankPlayerViewController())
        self.list = [vc0,vc1]
    }
    
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let data = object as? DateListModel else {
            return false
        }
        return data.id == self.id
    }
}

