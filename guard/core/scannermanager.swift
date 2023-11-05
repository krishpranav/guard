//
//  scannermanager.swift
//  guard
//
//  Created by Krisna Pranav on 05/11/23.
//

import Foundation
import Combine
import AppKit

class ScannerManager: ObservableObject {
    @Published var scanResults: [Vulnerability] = []
    @Published var progress: Double = 0
    @Published var scanning: Bool = false
    private var totalModules: Int = 0
    
    func startScan(category: String?) {
        scanning = true
        DispatchQueue.global(qos: .userInitiated).async {
            if let category = category {
            }
        }
    }
}
