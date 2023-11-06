//
//  diagnostic_check.swift
//  guard
//
//  Created by Krisna Pranav on 06/11/23.
//

import Foundation

class DiagnosticCheck: Vulnerability {
    init() {
        super.init(name: "Check Sending Diagnostic and Usage Data To Apple", description: "Check if diagnostic and usage data are sending or not", category: "Privacy", remediation: "Go to sys preferences > security and privacy > privacy > analytics & improvements, select 'OFF' ", severity: "Low", documentation: "no docs", mitigation: "To protect your privacy and potential leak", docID: 24)
    }
    
    override func check() {
        
    }
}
