//
//  java.swift
//  guard
//
//  Created by Krisna Pranav on 05/11/23.
//

import Foundation

class JavaCheck: Vulnerability {
    override func check() {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/java")
        task.arguments = ["--version"]
        
        let outputPipe = Pipe()
        task.standardError = outputPipe
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: outputData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            if output.lowercased().contains("java 1.6") {
                status = "Update java version"
                checkStatus = "Red"
            } else {
                status = "Java is up-to-data"
                checkStatus = "Green"
            }
            
        } catch let e {
            print("Error checking \(name): \(e)")
            self.error = e
            checkStatus = "Yellow"
            status = "Error checking java 6"
        }
    }
    
    init() {
        super.init(name: "Check java 6 status", description: "Check java 6 is present or not cause due to some vulnerability", category: "Security", remediation: "Install a newer version of java", severity: "High", documentation: "https://www.java.com/en/", mitigation: "Using the latest version of java may prevent various attacks", docID: 25)
    }
}
