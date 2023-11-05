//
//  scanner.swift
//  guard
//
//  Created by Krisna Pranav on 05/11/23.
//

import Foundation

class Scanner {
    var modules: [Vulnerability] = []
    var moduleCount: Int {
        modules.count
    }
    
    func loadModules(category: String? = nil) {
        modules = []
        
        if let category = category {
            modules = modules.filter { $0.category == category }
        }
    }
    
    func runScan(progressHandler: @escaping (Vulnerability) -> Void) {
        for module in modules {
            do {
                module.check()
                progressHandler(module)
            }
        }
    }
}
