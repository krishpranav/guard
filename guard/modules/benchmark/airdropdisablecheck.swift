//
//  airdropdisablecheck.swift
//  guard
//
//  Created by Krisna Pranav on 05/11/23.
//

import Foundation

class AirDropDisableCheck: Vulnerability {
    override func check() {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/defaults")
        task.arguments = ["read", "com.apple.NetworkBrowser", "DisableAirDrop"]
        let outputPipe = Pipe()
        task.standardOutput = outputPipe
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: outputData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            if output.lowercased() == "1" {
                status = "Airdrop is disabled!!"
                checkStatus = "Green"
            } else {
                status = "Airdrop is enabled!!"
                checkStatus = "Red"
            }
            
        } catch let e {
            print("Error checking \(name): \(e)")
            checkStatus = "Yellow"
            status = "Error checking Airdrop status"
            self.error = e
        }
    }
    
    init() {
        super.init(
            name: "airdrop disabled or not checker",
            description: "checks airdrop is disabled or not",
            category: "Benchmark CIS",
            remediation: "To disable airdrop open finder and disable it",
            severity: "Medium",
            documentation: "for more information about airdrop please check out the apple official documentation",
            mitigation: "Disabling helps prevent unauthorized access to your remote pc",
            checkStatus: "",
            docID: 123
        )
    }
}
