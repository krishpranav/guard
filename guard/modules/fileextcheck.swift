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
}
