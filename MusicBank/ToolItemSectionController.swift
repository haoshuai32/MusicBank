//
//  ToolItemListSectionController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import Foundation
import IGListKit

class ToolItemSectionController: ListBindingSectionController<ListDiffable>,
                                 ListBindingSectionControllerDataSource,
                                 ListBindingSectionControllerSelectionDelegate{
    
    var text: NumberText?
    
    override init() {
        super.init()
        self.dataSource = self
        self.selectionDelegate = self
    }
    // MARK: ListBindingSectionControllerDataSource
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        if let data = text {
            debugPrint("重新设置数据1",data.text)
            return [data]
        }
        
        guard let data = object as? NumberText else {
            return []
        }
        debugPrint("重新设置数据2",data.text)
        return [data]
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "ToolItemCell", bundle: nil, for: self, at: index) as! ToolItemCell
        return cell
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        let height = collectionContext?.containerSize.width ?? 0
        return CGSize(width: height, height: 80)
    }
    



    // MARK: ListBindingSectionControllerSelectionDelegate

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        guard let data = viewModel as? NumberText else { return }
        
        debugPrint("点击重新刷数据",data.id)
        // id需要变化才可以进行数据的绑定
        text = NumberText(id: data.id + 50, text: "我是新刷新的数据\(data.id)")
        update(animated: true)
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didDeselectItemAt index: Int, viewModel: Any) {}

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didHighlightItemAt index: Int, viewModel: Any) {}

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didUnhighlightItemAt index: Int, viewModel: Any) {}
}
