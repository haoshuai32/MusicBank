//
//  MusicBankAlbumImageCell.swift
//  MusicBank
//
//  Created by haoshuai on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

class MusicBankSongItemModel: ListDiffable {
    
    let id: Int
    
    let playCount: Int
    
    let image: UIImage
    
    let name: String
    
    let logo: Bool
    
    
    init(id: Int,playCount:Int,image: UIImage,name:String,logo: Bool) {
        self.id = id
        self.playCount = playCount
        self.image = image
        self.name = name
        self.logo = logo
    }
    
    var hash: String {
        return "\(id)&\(playCount)&\(name)"
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return hash as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
//        if self === object { return true }
        guard let object = object as? MusicBankSongItemModel else { return false }
        return object.hash == self.hash
    }
    
    
}

//class MusicBankAlbumImageSectionController: ListSectionController {
//
//    var dataSource: MusicBankSongItemModel?
//
//    override init() {
//        super.init()
//        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
//    }
//
//    override func numberOfItems() -> Int {
//        return 1
//    }
//
//    override func sizeForItem(at index: Int) -> CGSize {
//        // 121 + 8 + 32
//        return CGSize(width: 121, height: 161)
//    }
//
//    override func cellForItem(at index: Int) -> UICollectionViewCell {
//
//        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "MusicBankAlbumImageCell", bundle: nil, for: self, at: index) as? MusicBankAlbumImageCell else  {
//            fatalError()
//        }
//
//        guard let data = self.dataSource else {
//            fatalError()
//        }
//
//        cell.imaegView.image = data.image
//        cell.countLabel.text = "\(data.playCount)"
//        cell.titleLabel.text = data.name
//        return cell
//    }
//
//    override func didUpdate(to object: Any) {
//        guard let data = object as? MusicBankSongItemModel else {
//            fatalError()
//        }
//        self.dataSource = data
//    }
//
//
//}

class MusicBankAlbumImageSectionController:
    ListBindingSectionController<ListDiffable>,
    ListBindingSectionControllerDataSource,
    ListBindingSectionControllerSelectionDelegate,
    ListDisplayDelegate {
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        
    }
    
    
    override init() {
        super.init()
        // 设置 Section
        self.inset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        dataSource = self
        selectionDelegate = self
        displayDelegate = self
        
        minimumLineSpacing = 10
    }
    
    // 这里其实 是接受的 MusicBankSongListModel 数据
    var songList: [MusicBankSongItemModel] = []
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        debugPrint("重新更新数据", object)
        if songList.count > 0 {
            return songList
        }
        guard let data = object as? MusicBankSongListModel else {
            assert(false)
            return []
        }
        songList = data.dataSouce
        return data.dataSouce
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "MusicBankAlbumImageCell", bundle: nil, for: self, at: index) as? MusicBankAlbumImageCell else {
            fatalError()
        }
        return cell
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        
        return MusicBankAlbumImageCell.Size
    }
    
    
    
    // // MARK: ListBindingSectionControllerSelectionDelegate
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        debugPrint("选中数据并且进行数据的更新",viewModel,index)
//        var objc = viewModel
        guard let data = viewModel as? MusicBankSongItemModel else {
            assert(false)
            return
        }
        
        let vc = UIStoryboard.Main.instantiate(MusicBankPlayerViewController.self)
        vc.modalPresentationStyle = .fullScreen
        self.viewController?.present(vc, animated: true, completion: nil)
//        self.viewController?.navigationController?.pushViewController(vc, animated: true)
        
        let item = MusicBankSongItemModel(id: data.id, playCount: data.playCount + 1, image: data.image, name: data.name, logo: data.logo)
        songList[index] = item
//        MusicBankSongListModel(list: songList)
        update(animated: true, completion: nil)
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didDeselectItemAt index: Int, viewModel: Any) {
        
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didHighlightItemAt index: Int, viewModel: Any) {
        
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didUnhighlightItemAt index: Int, viewModel: Any) {
        
    }
    


   
    
    
}

class MusicBankAlbumImageCell: UICollectionViewCell,
                               ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let data = viewModel as? MusicBankSongItemModel else {
            fatalError()
        }
        self.imaegView.image = data.image
        self.countLabel.text = "\(data.playCount)"
        self.titleLabel.text = data.name
    }
    
    
    override var isHighlighted: Bool{
        didSet {
            debugPrint("高粱")
        }
    }
    
    static let Size = CGSize(width: 121, height: 161)
    
    @IBOutlet weak var imaegView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var playImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
