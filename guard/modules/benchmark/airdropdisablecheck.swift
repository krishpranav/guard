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
                checkstatus = "Green"
            } else {
                status = "Airdrop is enabled!!"
                checkstatus = "Red"
            }
            
        } catch let e {
            print("Error checking \(name): \(e)")
            checkstatus = "Yellow"
            status = "Error checking Airdrop status"
            self.error = e
        }
    }
}
