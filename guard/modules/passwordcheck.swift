//
//  passwordcheck.swift
//  guard
//
//  Created by Krisna Pranav on 06/11/23.
//

import Foundation

class PasswordsCheck: Vulnerability {
    override func check() {
        let task = Process()
        let outputPipe = Pipe()
        
        task.executableURL = URL(fileURLWithPath: "/usr/bin/defaults")
        task.arguments = ["read", "/Library/Preferences/com.apple.loginwindow.plist", "RetriesUntilHint"]
            
        task.standardOutput = outputPipe
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: outputData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            if output.lowercased() == "0" {
                status = "Password hint is disabled"
                checkStatus = "Green"
            } else {
                status = "Password hint is enabled"
                checkStatus = "Red"
            }
            
        } catch let e {
            print("Error checking \(name): \(e)")
            self.error = e
            checkStatus = "Yellow"
        }
        
    }
    
    init() {
        super.init(name: "Password Hint Check", description: "Check whether password hint is enabled or disabled", category: "Security", remediation: "To disable password hints Go to Users & Groups > Login Options and uncheck the 'Show password hint'  options ", severity: "Medium", documentation: "For more check out the apple's documentation", mitigation: "By disabling you can reduce the chance of login into your pc through hints", docID: 30)
    }
}
