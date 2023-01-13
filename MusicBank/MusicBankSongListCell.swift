//
//  MusicBankSongListCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/4/3.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift
class MusicBankSongListModel: ListDiffable {
    let dataSouce: [MusicBankSongItemModel]
    init(list: [MusicBankSongItemModel]) {
        self.dataSouce = list
    }
    var hash: String {
        return dataSouce.map{$0.hash}.joined(separator: "&")
    }
    func diffIdentifier() -> NSObjectProtocol {
        return hash as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? MusicBankSongListModel else { return false }
        return object.hash == self.hash
    }
    
    
}

class MusicBankSongListSectionController:ListSectionController,
                                         ListAdapterDataSource,
                                         ListSupplementaryViewSource
    {

    var dataSource: MusicBankSongListModel?
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self.viewController)
    }()
    
    override init() {
        super.init()
        adapter.dataSource = self
        supplementaryViewSource = self
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return MusicBankSongListCell.Size
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "MusicBankSongListCell", bundle: nil, for: self, at: index)  as? MusicBankSongListCell else {
            fatalError()
        }
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    override func didUpdate(to object: Any) {
        guard let data = object as? MusicBankSongListModel else {
            fatalError()
            return
        }
        self.dataSource = data
    }
    
    // MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        debugPrint("需要渲染数据",dataSource?.dataSouce.count)
        guard let data = self.dataSource else {
            fatalError()
        }
        // 传递一个数组 表示有一个 song list
        return [data]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return MusicBankAlbumImageSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    // MARK: ListSupplementaryViewSource
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }

    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return userHeaderView(atIndex: index)
        case UICollectionView.elementKindSectionFooter:
            fatalError()
        default:
            fatalError()
        }
        fatalError()
    }

    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 46)
    }
    let dis = DisposeBag()
    //
    private func userHeaderView(atIndex index: Int) -> UICollectionReusableView {
        guard let view = collectionContext?.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
                for: self, nibName: "MusicBankSongListHeaderCell", bundle: nil, at: index) as? MusicBankSongListHeaderCell else {
            fatalError()
        }
        
        
        view.moreButton.rx
            .tap.subscribe(onNext: { (_) in
                debugPrint("点击更多")
            })
            .disposed(by: dis)
        return view
    }
}

class MusicBankSongListCell: UICollectionViewCell {

    static let Size = CGSize(width: UIScreen.main.bounds.width, height: 161)
    
    @IBOutlet weak var collectionView: ListCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        // Initialization code
    }

}
