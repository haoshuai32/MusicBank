//
//  MusicBankMineViewController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/13.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

/*
 https://www.baidu.com/s?ie=utf-8&f=3&rsv_bp=1&rsv_idx=1&tn=baidu&wd=ios%E4%B8%A4%E4%B8%AAtableview%E6%BB%9A%E5%8A%A8%E5%86%B2%E7%AA%81&fenlei=256&rsv_pq=985bad1b0002d271&rsv_t=9aafmM8yKik2%2BJc1pBO3fHHdrFRJ6H85jHSq7HVNWpdYRhXrg17DtSw5Q2g&rqlang=cn&rsv_enter=1&rsv_dl=ts_1&rsv_sug3=22&rsv_sug1=16&rsv_sug7=100&rsv_sug2=1&rsv_btype=i&prefixsug=iOS%2520%25E4%25B8%25A4%25E4%25B8%25AAtableview%2520&rsp=1&inputT=10331&rsv_sug4=10332
 
 https://www.jb51.net/article/172350.htm
 
 https://github.com/qingfengiOS/QFMultipleScrollView/blob/master/QFMultipleScrollView/ViewController.swift
 
 https://blog.csdn.net/lining1041204250/article/details/80363392
 
 https://www.jianshu.com/p/8bf6c2953da3
 
 https://www.jianshu.com/p/d60ce07ef311
 */

class MultiResponseListCollectionView: ListCollectionView,UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

class MusicBankMineViewController: MusicBankViewController {

    @IBOutlet weak var collectionView: MultiResponseListCollectionView!
    
    let maxOffset: CGFloat = 130 + 41
    var superCanScroll = true
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
        
        

        NotificationCenter.default.rx
            .notification(Notification.Name.ScrollEnabled.Mine)
            .subscribe(onNext: { (objc) in
                guard let isScrollEnabled = objc.object as? Bool else {
                    fatalError()
                }
                debugPrint("注释话动画状态", isScrollEnabled)
                self.superCanScroll = isScrollEnabled
            })
            .disposed(by: disposeBag)
    }
    
    
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//     return true
//     }
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
        debugPrint("主图滑动", scrollView.contentOffset.y, superCanScroll)
        if !superCanScroll {
            scrollView.contentOffset.y = maxOffset
            NotificationCenter.default.post(name: NSNotification.Name.ScrollEnabled.Find, object: true)
        } else {
            if scrollView.contentOffset.y >= maxOffset {
                scrollView.contentOffset.y = maxOffset
                superCanScroll = false
                NotificationCenter.default.post(name: NSNotification.Name.ScrollEnabled.Find, object: true)
            }
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
        let vc1 = VCModel(id: 1, vc: MusicBankSearchViewController())
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

