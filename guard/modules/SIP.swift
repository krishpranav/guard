//
//  SIP.swift
//  guard
//
//  Created by Krisna Pranav on 05/11/23.
//

import Foundation

class SIPCheck: Vulnerability {
    
    override func check() {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/csrutil")
        task.arguments = ["status"]
        
        let outputPipe = Pipe()
        task.standardOutput = outputPipe
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: outputData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        } catch let e {
            print("Error checking \(name): \(e)")
            self.error = e
            checkStatus = "Yellow"
        }
    }
}
