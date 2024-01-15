//
//  JsonProcessor.swift
//  PocGlobo
//
//  Created by Alessandro Teixeira Lima on 15/01/24.
//

import Foundation
import SwiftUI

class JsonProcessor {
    private var timer: Timer?
    
    lazy var event: Event = { return Event() }()
    lazy var httpRequestManager =  HTTPRequestManager()
    
    init() {
        
        if let db = DBConstants.db {
            event.setManagerAndDB(manager: DBConstants.sqliteManager, db: db)
        }
        
        startProcessing()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func startProcessing() {
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(TaskEnvironment.waitingTime.rawValue), target: self, selector: #selector(processJson), userInfo: nil, repeats: true)
    }

    private func stopProcessing() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func processJson() {
        
        
        var ids:[Int] = []
        
        if Utils.shared.hasInternetConnection() {
            
            let events = event.selectTopNEvent(limit: Int(TaskEnvironment.numberEvents.rawValue))
            let jsonEncoder = JSONEncoder()
            let jsonData = try! jsonEncoder.encode(events)
            
            if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                let extractedIds = event.extractIds(from: jsonObject)
                ids = extractedIds
                if ids.count > 0 {
                    print("Processando JSON a cada \(TaskEnvironment.waitingTime.rawValue) segundos...")
                    print(ids)
                }
            } else {
                print("Error processing JSON.")
            }
            
            if ids.count > 0 {
                httpRequestManager.makePostRequest(with: jsonData) { result in
                    switch result {
                    case .success(let success):
                        success == true ? print("Request successful: \(success)") : print("Request fail: \(success)")
                        if success { _ = self.event.deleteRowsInBatch(ids: ids)}
                    case .failure(let error):
                        switch error {
                        case .timeout:
                            print("Request timed out")
                        case .invalidResponse:
                            print("Invalid response")
                        case .requestFailed(let underlyingError):
                            print("Request failed with underlying error: \(underlyingError)")
                        }
                    }
                }
            }
        }
        
    }
}
