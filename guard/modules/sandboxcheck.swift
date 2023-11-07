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
    
    }
    
    init() {
        super.init(name: "Sandbox Check", description: "Check if app sandbox is enabled for the current app", category: "Security", remediation: "Enable App Sandbox for the using of the entilements file", severity: "High", documentation: "Visit: https://developer.apple.com/documentation/security/app_sandbox", mitigation: "Enable App Sandbox for the app", docID: 10)
    }
}
