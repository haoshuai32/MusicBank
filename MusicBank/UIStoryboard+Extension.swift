//
//  UIStoryboard+Extension.swift
//  MusicBank
//
//  Created by flqy on 2021/3/24.
//  Copyright © 2021 onelact. All rights reserved.
//


import UIKit
extension UIStoryboard {
    
    
    static var Main: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: nil)
    }()
    
    
    func instantiate<T: UIViewController>(_ viewController: T.Type) -> T  {
        let className = NSStringFromClass(viewController.classForCoder())
        guard let identifier = className.split(separator: ".").last else {
            fatalError()
        }
        return self.instantiateViewController(withIdentifier: String(identifier)) as! T
    }

    
}
