//
//  MusicBankNavigationCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/4/3.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import RxSwift
import IGListKit
import ObjectMapper



class MusicBankNavigationBarListModel: ListDiffable {
    
    let id: Int
    
    let dataSource: [MusicBankNavigationBarItemModel]
    
    init(id: Int, list: [MusicBankNavigationBarItemModel]) {
        self.id = id
        self.dataSource = list
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? MusicBankNavigationBarListModel else {
            return false
        }
        return object.id == self.id
    }
        
}

class MusicBankNavigationSectionController: ListSectionController,
                                            ListAdapterDataSource {

    
    var dataSource: MusicBankNavigationBarListModel?
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self.viewController)
    }()
    
    override init() {
        super.init()
        adapter.dataSource = self
        self.inset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return MusicBankNavigationCell.Size
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "MusicBankNavigationCell", bundle: nil, for: self, at: index) as? MusicBankNavigationCell else {
            fatalError()
        }
        self.adapter.collectionView = cell.collectionView
        return cell
    }
    
    override func didUpdate(to object: Any) {
        guard let data = object as? MusicBankNavigationBarListModel else {
            fatalError()
        }
        self.dataSource = data
    }
    
    // MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.dataSource?.dataSource ?? []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return MusicBankNavigationBarSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

class MusicBankNavigationCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: ListCollectionView!
    
    static let Size = CGSize(width: UIScreen.main.bounds.width, height: 96.5)
    
    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.defaultSeparator.cgColor
        return layer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 11)
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        contentView.layer.addSublayer(separator)
        separator.frame = CGRect(x: 0, y: 95, width: UIScreen.main.bounds.width, height: 0.5)
        // Initialization code
    }

}
