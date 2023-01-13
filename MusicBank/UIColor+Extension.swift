//
//  UIColor+Extension.swift
//  MusicBank
//
//  Created by flqy on 2021/3/13.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit

extension UIColor {
    
    var image: UIImage {
        // 加入图片缓存
        return UIImage.creatImage(color: self)!
    }
    
    class var background: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    class var secondaryBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .secondarySystemBackground
        } else {
            return .lightGray
        }
    }
    
    class var defaultSeparator: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.separator
        } else {
            return UIColor(red: 200 / 255.0,
                           green: 199 / 255.0,
                           blue: 204 / 255.0,
                           alpha: 1)
        }
    }
    
    class var titleLabel: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .darkText
        }
    }
    
    class var detailLabel: UIColor {
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        } else {
            return .lightGray
        }
    }
    
}


