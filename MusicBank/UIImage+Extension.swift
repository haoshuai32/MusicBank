//
//  UIImage+Extension.swift
//  MusicBank
//
//  Created by flqy on 2021/3/13.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import ImageIO

extension UIImage {
    
    static func creatImage(color: UIColor) -> UIImage? {
        let rect = CGRect(x:0,y:0,width:1,height:1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    static func resizedImage(at url: URL, for size: CGSize) -> UIImage? {
        
        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceThumbnailMaxPixelSize: max(size.width, size.height)
        ]

        guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)
        else {
            return nil
        }

        return UIImage(cgImage: image)
    }
    
    func resizedImage(size: CGSize) -> UIImage? {
        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceThumbnailMaxPixelSize: max(size.width, size.height)
        ]

        guard
            
            let imageData = self.jpegData(compressionQuality: 1.0),
            let cfData = CFBridgingRetain(imageData),
            let imageSource = CGImageSourceCreateWithData(cfData as! CFData, nil),
            let image = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)
        else {
            return nil
        }
        
        return UIImage(cgImage: image)
    }
    
    
    /**
     压缩图片到指定大小（先压缩质量，如果还是达不到，再压缩宽高） -- 推荐 --

     @param image 目标图片
     @param maxLength 需要压缩到的byte值
     @return 压缩后的图片
     */
    func compressTo(kb: CGFloat) -> Data? {
        let image = self
        let maxLength:CGFloat = kb * 1024.0
        var compression: CGFloat = 1
        var imageData: Data
        guard let data = image.jpegData(compressionQuality: compression) else {
            return nil
        }
        imageData = data
        if CGFloat(data.count) < maxLength {
            return data
        }
        
        var maxValue: CGFloat = 1;
        var min: CGFloat = 0;
        // 二分最大10次，区间范围精度最大可达0.00097657；第6次，精度可达0.015625，10次，0.000977
        for _ in 0 ..< 10 {
            compression = (maxValue + min) / 2.0;
            guard let data = image.jpegData(compressionQuality: compression) else {
                return nil
            }
            imageData = data
            if (CGFloat(data.count) < maxLength * 0.9) {
                min = compression;
            } else if (CGFloat(data.count) > maxLength) {
                maxValue = compression;
            } else {
                break;
            }
        }

        // 如果二分法之后，还是不符合大小
        if (CGFloat(imageData.count) > maxLength) {
            var resultImage: UIImage
            guard let image = UIImage(data: imageData) else {
                return nil
            }
            resultImage = image
            while (CGFloat(imageData.count) > maxLength) {
                let ratio = maxLength / CGFloat(data.count)
                // 使用NSUInteger不然由于精度问题，某些图片会有白边
                let size = CGSize(width: Int(resultImage.size.width * CGFloat(sqrtf(Float(ratio)))), height: Int(resultImage.size.height * CGFloat(sqrtf(Float(ratio)))))
                    
                let maxPixelSize = max(size.width, size.height)
                guard let data = self.compressByImageIOFromData(data: imageData, maxPixelSize: maxPixelSize) else {
                    return nil
                }
                imageData = data
            }
        }
        return imageData
    }

    // 根据指定size 使用 ImageIO 重新绘图
    func compressByImageIOFromData(data: Data, maxPixelSize:CGFloat) -> Data? {
        if (data.count <= 0) {
            return nil;
        }
        if (maxPixelSize <= 0) {
            return data
        }

        let scale = UIScreen.main.scale
        let sizeTo = maxPixelSize * scale
        let cfData = data as CFData

        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceThumbnailMaxPixelSize: sizeTo
        ]
        
//        - (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
//            UIGraphicsBeginImageContext(image1.size);
//           
//            // Draw image1
//            [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
//           
//            // Draw image2
//            [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
//           
//            UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
//           
//            UIGraphicsEndImageContext();
//           
//            return resultingImage;
//        }
        
        guard
            
            let imageSource = CGImageSourceCreateWithData(cfData, nil),
            let thumImg = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)
            
        else {
            return nil
        }
        let image = UIImage(cgImage: thumImg, scale: scale, orientation: .up)
        return image.jpegData(compressionQuality: 1.0)
    }
    
}
