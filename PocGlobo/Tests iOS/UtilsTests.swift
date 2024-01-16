//
//  UtilsTests.swift
//  Tests iOS
//
//  Created by Alessandro Teixeira Lima on 15/01/24.
//

import XCTest
@testable import PocGlobo

class UtilsTests: XCTestCase {
    
    func testHasInternetConnection() {
        let utils = Utils.shared
        
        let result = utils.fakeTest()
        
        XCTAssertTrue(result, "A conexão com a internet deveria estar disponível")
        
    }
    
}
