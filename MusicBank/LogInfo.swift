//
//  LogInfo.swift
//  Merchant
//
//  Created by flqy on 2021/1/7.
//  Copyright © 2021 onelcat. All rights reserved.
//

import Foundation

struct MerchantLog {
    
    fileprivate static var logFile:URL?
    
    fileprivate static func write(_ path: String = #file ,_ line: Int = #line, _ function: String = #function,logs: [String]) {
        
        let file:URL
        if let url = MerchantLog.logFile {
            file = url
        } else {
            guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                assert(false)
                return
            }
            file = path.appendingPathComponent("log.log")
            MerchantLog.logFile = file
        }
        let time = "\(Date())"
        let logStr = "\(time)__\(path):\(line) #\(function)# \r\n \(logs.joined()) \r\n ---------------------------------------- \r\n"
        
        guard let data = logStr.data(using: .utf8) else {
            assert(false)
            return
        }
        
        do {
            if FileManager.default.fileExists(atPath: file.path) {
                let fileHandle = try FileHandle(forWritingTo: file)
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
            } else {
                try data.write(to: file)
            }
        } catch let error {
            assert(false, error.localizedDescription)
        }
    }
    
    fileprivate static func log(_ file: String = #file ,_ line: Int = #line, _ function: String = #function,logs: [String]) {
        let logStr = "\(file):\(line) #\(function)# \r\n \(logs.joined()) \r\n"
        let time = "\(Date())"
        print(time, logStr)
    }
    
}


func Log(_ file: String = #file ,_ line: Int = #line, _ function: String = #function,logs: Any ...) {
    let log = logs.map{"\($0)"}
    let nf = file as NSString
    
    #if DEBUG
    MerchantLog.log(nf.lastPathComponent,line , function, logs: log)
    #else
    MerchantLog.write(nf.lastPathComponent,line, function,logs: log)
    #endif
}
