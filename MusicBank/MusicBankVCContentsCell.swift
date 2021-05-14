//
//  MusicBankVCContentsCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/25.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

class MusicBankVCContentsCell: UICollectionViewCell {

    @IBOutlet weak var colleciontView: ListCollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

class MusicBankVCSectionController: ListSectionController {
    
    var dataSource: UIViewController?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 72.5)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: UICollectionViewCell.self, for: self, at: index),
              let view = dataSource?.view
        else {
            fatalError()
        }
        view.frame = CGRect(origin: CGPoint.zero, size: cell.frame.size)
        cell.addSubview(view)
        return cell
    }

    override func didUpdate(to object: Any) {
        guard let data = object as? UIViewController else {
            fatalError()
        }
        self.dataSource = data
    }
}

class MusicBankVCContentsSectionController: ListSectionController,ListAdapterDataSource {

    
    
    var dataSource: UIViewController?
    
    private
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 72.5)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
         let cell = collectionContext?.dequeueReusableCell(withNibName: "MusicBankVCContentsCell", bundle: nil, for: self, at: index) as! MusicBankVCContentsCell
        return cell
    }

    override func didUpdate(to object: Any) {
        guard let data = object as? UIViewController else {
            fatalError()
        }
        self.dataSource = data
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return (1...3).map{NSNumber(value: $0)}
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return MusicBankVCSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

