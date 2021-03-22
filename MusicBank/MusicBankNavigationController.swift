//
//  MusicBankNavigationController.swift
//  MusicBank
//
//  Created by flqy on 2021/3/13.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit

final class MusicBankNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactivePopGestureRecognizer?.delegate = self;
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
    
    

}

extension MusicBankNavigationController:UINavigationBarDelegate ,UIGestureRecognizerDelegate,UINavigationControllerDelegate {
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if viewControllers.count < (navigationBar.items?.count)! {
            return true
        }

        return true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if self.viewControllers.count == 1{
            return false;
        } else {
            return true
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        let success = gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
        return success
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if(viewController == self){
            navigationController.setNavigationBarHidden(true, animated: true)
        }else{
            
            //系統相冊繼承自 UINavigationController 這個不能隱藏 所有就直接return
            if navigationController.isKind(of: UIImagePickerController.self){
                return
            }
            
            //不在本頁時，顯示真正的navbar
            navigationController.setNavigationBarHidden(false, animated: true)
            //當不顯示本頁時，要麼就push到下一頁，要麼就被pop了，那麼就將delegate設置為nil，防止出現BAD ACCESS
            //之前將這段代碼放在viewDidDisappear和dealloc中，這兩種情況可能已經被pop了，self.navigationController為nil，這裡采用手動持有navigationController的引用來解決
            if let delegate = navigationController.delegate {
                if delegate.isEqual(self){
                    //如果delegate是自己才設置為nil，因為viewWillAppear調用的比此方法較早，其他controller如果設置了delegate就可能會被誤傷
                    navigationController.delegate = nil;
                }
            }
        }
    }
}
