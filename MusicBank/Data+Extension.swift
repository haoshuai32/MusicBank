//
//  Data+Extension.swift
//  Merchant
//
//  Created by flqy on 2021/1/8.
//  Copyright © 2021 onelcat. All rights reserved.
//

import Foundation
extension Data {
    var hexString: String {
        return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}


