//
//  fileextcheck.swift
//  guard
//
//  Created by Krisna Pranav on 06/11/23.
//

import Foundation

class FileExtCheck: Vulnerability {
    override func check() {
        let task = Process()
        let outputPipe = Pipe()
        
        task.executableURL = URL(fileURLWithPath: "/usr/bin/defaults")
        task.arguments = ["read", "NSGlobalDomain", "AppleShowAllExtensions"]
        
        task.standardOutput = outputPipe
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: outputData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            if output.lowercased() == "1" {
                status = "Filename extension is enabled"
                checkStatus = "Green"
            } else {
                status = "Filename extension is disabled"
                checkStatus = "Red"
            }
        } catch let e {
            print("Error checking \(name): \(e)")
            status = "Error checking filename extensions status"
            checkStatus = "Yellow"
            self.error = e
        }
    }
    
    init() {
        super.init(name: "Check File EXT status", description: "This checks and ensures the filename extensions are turned on in your system or not", category: "Security", remediation: "To turn on filename extension, go to Finder > Preferences > Advanced, and check the 'Show all filename extensions'", severity: "Low", documentation: "for more information, please visit: https://support.apple.com/guide/mac-help/show-or-hide-filename-extensions-on-mac-mh26782/mac", mitigation: "By turning on you will identify the filename extension it also prevents yourself from opening malicious file containing backdoors", docID: 32)
    }
}
