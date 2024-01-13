//
//  Utils.swift
//  PocGlobo
//
//  Created by Alessandro Teixeira Lima on 13/01/24.
//

import Foundation
import Reachability

class Utils {
    
    static let shared = Utils()
    
    func hasInternetConnection() -> Bool {
        let reachability = try? Reachability()

        switch reachability?.connection {
        case .unavailable, .none:
            return false
        case .wifi, .cellular:
            return true
        }
    }
}
