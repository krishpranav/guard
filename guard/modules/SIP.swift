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
            
            if output.lowercased().contains("enabled.") {
                status = "SIP is enabled"
                checkStatus = "Green"
            } else {
                status = "SIP is not enabled"
                checkStatus = "Red"
            }
            
        } catch let e {
            print("Error checking \(name): \(e)")
            self.error = e
            checkStatus = "Yellow"
        }
    }
    
    init() {
        super.init(name: "Check system integerity protection (SIP)", description: "checks and verifies if SIP protection is enabled  or not", category: "Security", remediation: "To enable SIP restart your pc in recovery mode and run `csrutil enable`", severity: "High", documentation: "For more information please visist https://support.apple.com/en-us/HT204899", mitigation: "SIP is a very important security feature and you should keep it enabled to avoid unauthorized write access", docID: 20)
    }
}
