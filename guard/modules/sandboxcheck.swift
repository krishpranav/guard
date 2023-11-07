//
//  sandboxcheck.swift
//  guard
//
//  Created by Krisna Pranav on 07/11/23.
//

import Foundation

class SandboxCheck: Vulnerability {
    
    override func check() {
        let task = Process()
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        
        task.executableURL = URL(fileURLWithPath: "/usr/bin/codesign")
        task.arguments = ["--display", "--entitlements", ":-", Bundle.main.bundlePath]
        
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: outputData, encoding: .utf8) ?? ""
            let entitlements = try PropertyListSerialization.propertyList(from: output.data(using: .utf8)!, options: [], format: nil) as? [String: Any]
            
            print("Entitlements: \(entitlements) ?? [:]")
            
            
            // TODO: check entitlements
            
        } catch let e {
            print("Error checking app sandbox: \(e)")
            self.error = e
        }
    }
    
    init() {
        super.init(name: "Sandbox Check", description: "Check if app sandbox is enabled for the current app", category: "Security", remediation: "Enable App Sandbox for the using of the entilements file", severity: "High", documentation: "Visit: https://developer.apple.com/documentation/security/app_sandbox", mitigation: "Enable App Sandbox for the app", docID: 10)
    }
}
