//
//  vuln.swift
//  guard
//
//  Created by Krisna Pranav on 05/11/23.
//

import Foundation

class Vulnerability: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let category: String
    let remediation: String
    let severity: String
    var status: String?
    var error: Error?
    
    init(name: String, description: String, category: String, remediation: String, severity: String, status: String) {
        self.name = name
        self.description = description
        self.category = category
        self.remediation = remediation
        self.severity = severity
        self.status = status
    }
    
    func check() {
        fatalError("method is not implemeneted")
    }
}
