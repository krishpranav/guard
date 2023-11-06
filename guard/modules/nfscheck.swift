//
//  nfscheck.swift
//  guard
//
//  Created by Krisna Pranav on 06/11/23.
//

import Foundation

class NfsCheck: Vulnerability {
    override func check() {
            /// TODO
    }
    
    init() {
        super.init(name: "Check NFS server status", description: "This ensures that nfs server is running or not, nfs server helps protecting your pc against potential pc attacks", category: "Security", remediation: "To configure nfs sever follow the steps in the documentation linked below.", severity: "Medium", documentation: "https://support.apple.com/en-us/HT210060", mitigation: "configuring nfs server helps protecting your system from vulnerabilities", docID: 29)
    }
}
