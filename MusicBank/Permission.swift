//
//  Permission.swift
//  Merchant
//
//  Created by flqy on 2021/1/11.
//  Copyright © 2021 onelcat. All rights reserved.
//

import UIKit

protocol RequestPermissionSettings:UIViewController {
    func requestInSettings(title: String, message: String)
}

extension RequestPermissionSettings {
    func requestInSettings(title: String, message: String) {
        let url = URL(string: UIApplication.openSettingsURLString)!
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "设 置", style: .default) { (action) in
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(url)
                }
            }
        }
        alert.addAction(ok)
        let cancel = UIAlertAction(title: "取 消", style: .default, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}


import  Photos

protocol PhotosPermission: RequestPermissionSettings {
    func requesPhotosPermission(completionHandler: @escaping ((Bool)->Void))
    func requestPhotosInSettings()
}



// 获取相册权限
extension PhotosPermission {
    
    func requesPhotosPermission(completionHandler: @escaping ((Bool)->Void)) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            completionHandler(true)
            break
        case .denied:
            self.requestPhotosInSettings()
            completionHandler(false)
            break
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async { [unowned self] in
                    switch status {
                    case .authorized:
                        completionHandler(true)
                        break
                    case .denied:
                        // 打开系统设置页面，让用户手动打开图片库访问权限
                        self.requestPhotosInSettings()
                        completionHandler(false)
                        break
                    default:
                        assert(false)
                        completionHandler(false)
                    break
                    }
                }
            } // requestAuthorization
            
            break
        default:
            completionHandler(false)
            assert(false)
            break
        }
    }
    
    func requestPhotosInSettings() {
        self.requestInSettings(title: "相册权限", message: "请在设置中打开相册的访问权限")
    }
}

protocol CameraPermission: RequestPermissionSettings {
    func requestCamera(completionHandler: @escaping ((Bool)->Void))
    func requestCameraInSettings()
}

extension CameraPermission {
    func requestCamera(completionHandler: @escaping ((Bool)->Void)) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (success) in
                DispatchQueue.main.async {
                    if success {
                        completionHandler(true)
                    } else {
                        completionHandler(false)
                    }
                }
            }
        case .authorized:
            completionHandler(true)
            break
        case .denied:
            self.requestCameraInSettings()
            completionHandler(false)
            break
        default:
            completionHandler(false)
            assert(false)
        } // authorizationStatus
    }
    func requestCameraInSettings() {
        self.requestInSettings(title: "相机权限", message: "请在设置中打开相机的访问权限")
    }
}

protocol LocationPermission: RequestPermissionSettings {
    func requestLocationInSettings()
}

extension LocationPermission {
    func requestLocationInSettings() {
        self.requestInSettings(title: "定位权限", message: "发布同城跑腿需要获取您的位置，请在设置中打开定位权限")
    }
}


