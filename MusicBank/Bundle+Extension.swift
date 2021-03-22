//
//  AppBundle.swift
//  Merchant
//
//  Created by flqy on 2021/1/21.
//  Copyright © 2021 onelcat. All rights reserved.
//

import Foundation

extension Bundle {
    /// App version
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }

    /// App name
    static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }

    /// Build number
    static var appBuildNumber: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
}
