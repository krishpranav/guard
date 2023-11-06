//
//  nfscheck.swift
//  guard
//
//  Created by Krisna Pranav on 06/11/23.
//

import Foundation

class NfsCheck: Vulnerability {
    override func check() {
        let taskone = Process()
        let tasktwo = Process()
        
        /// PIPES
        let pipeBetweenTasks = Pipe()
        let outputPipe = Pipe()
        
        taskone.executableURL = URL(fileURLWithPath: "/bin/launchctl")
        taskone.arguments = ["list"]
        
        tasktwo.executableURL = URL(fileURLWithPath: "/usr/bin/grep")
        tasktwo.arguments = ["-c", "com.apple.nfsd"]
        
        taskone.standardOutput = pipeBetweenTasks
        tasktwo.standardInput = pipeBetweenTasks
        tasktwo.standardError = outputPipe
        
        do {
            try taskone.run()
            try tasktwo.run()
                
            taskone.waitUntilExit()
            tasktwo.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: outputData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            if output == "0" {
                status = "NFS Server is disabled"
                checkStatus = "Green"
            } else {
                status = "NFS server is enabled"
                checkStatus = "Red"
            }
            
        } catch let e {
            print("Error checking \(name): \(e)")
            self.error = e
            checkStatus = "Yellow"
            status = "Error checking NFS server status"
        }
    }
    
    init() {
        super.init(name: "Check NFS server status", description: "This ensures that nfs server is running or not, nfs server helps protecting your pc against potential pc attacks", category: "Security", remediation: "To configure nfs sever follow the steps in the documentation linked below.", severity: "Medium", documentation: "https://support.apple.com/en-us/HT210060", mitigation: "configuring nfs server helps protecting your system from vulnerabilities", docID: 29)
    }
}
