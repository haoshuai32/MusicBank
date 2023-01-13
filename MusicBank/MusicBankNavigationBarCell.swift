//
//  MusicBankNavigationBarCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/4/3.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift



class MusicBankNavigationBarItemModel {
    let name: String
    let image: UIImage
    init(name: String,image: UIImage) {
        self.name = name
        self.image = image
    }
}

extension MusicBankNavigationBarItemModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? MusicBankNavigationBarItemModel else {
            return false
        }
        return object.name == self.name
    }
}


class MusicBankNavigationBarSectionController: ListSectionController {
    
    var dataSource: MusicBankNavigationBarItemModel?
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return MusicBankNavigationBarCell.Size
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "MusicBankNavigationBarCell", bundle: nil, for: self, at: index) as? MusicBankNavigationBarCell else {
            fatalError()
        }
        guard let data = self.dataSource else {
            fatalError()
        }
        cell.titleLabel.text = data.name
        cell.imageView.image = data.image
        return cell
    }
    
    override func didUpdate(to object: Any) {
        guard let data = object as? MusicBankNavigationBarItemModel else {
            fatalError()
        }
        self.dataSource = data
    }
    
    override func didSelectItem(at index: Int) {
        debugPrint("当前点击的数据", self.dataSource?.name ?? "❌")
    }
}

class MusicBankNavigationBarCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
//   16  46  30  46 ｜ 11 5 46 5 10 5
    static let Size = CGSize(width: 56.0, height: 96.5)
    
    override var isSelected: Bool {
        didSet {
            
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

}
