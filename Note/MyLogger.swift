//
//  MyLogger.swift
//  Note
//
//  Created by Ирина Соловьева on 30/06/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import Foundation
import UIKit
import CocoaLumberjack

class MyLogger {
    
var ddFileLogger: DDFileLogger!

var logFileDataArray: [NSData] {
    get {
        let logFilePaths = ddFileLogger.logFileManager.sortedLogFilePaths
        var logFileDataArray = [NSData]()
        for logFilePath in logFilePaths {
            let fileURL = NSURL(fileURLWithPath: logFilePath)
            if let logFileData = try? NSData(contentsOf: fileURL as URL, options: NSData.ReadingOptions.mappedIfSafe) {
                // Insert at front to reverse the order, so that oldest logs appear first.
                logFileDataArray.insert(logFileData, at: 0)
            }
        }
        return logFileDataArray
    }
}

}
