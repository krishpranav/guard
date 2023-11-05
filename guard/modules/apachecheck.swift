//
//  apachecheck.swift
//  guard
//
//  Created by Krisna Pranav on 05/11/23.
//

import Foundation

class HttpCheck: Vulnerability {
    
    override func check() {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/apachectl")
        task.arguments = ["-t"]
        
        let outputPipe = Pipe()
        task.standardOutput = outputPipe
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: outputData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            if output.lowercased().contains("snytax ok") {
                status = "Apache server is running."
                checkstatus = "Red"
            } else {
                status = "Apache server is not running"
                checkstatus = "Green"
            }
        } catch let e {
            print("Error checking \(name): \(e)")
            self.error = e
            checkstatus = "Yellow"
            status = "Error checking HTTP status"
        }
    }
    
    init() {
        super.init(name: "Check http status", description: "checks http sever is running or not", category: "Security", remediation: "to disable the builtin apache server please check the documentation", severity: "Medium", documentation: "visit: https://support.apple.com/en-us/HT210060", mitigation: "Disabling helps protecting your system and avoids attacks from outer attacks", docID: 28)
    }
}
