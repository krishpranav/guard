//
//  vuln.swift
//  guard
//
//  Created by Krisna Pranav on 05/11/23.
//

import Foundation
import AppKit

class Vulnerability: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let category: String
    let remediation: String
    let severity: String
    let documentation: String?
    var status: String?
    let mitigation: String
    var error: Error?
    var checkstatus: String?
    let docID: Int32
    
    
    init(name: String, description: String, category: String, remediation: String, severity: String, documentation: String, mitigation: String, checkstatus: String? = nil, docID: Int32) {
        
        self.name = name
        self.description = description
        self.category = category
        self.remediation = remediation
        self.severity = severity
        self.documentation = documentation
        self.mitigation = mitigation
        self.checkstatus = checkstatus
        self.docID = docID
    }
    
    func check() {
        fatalError("The method should be implemented in subclasses.")
    }
}
