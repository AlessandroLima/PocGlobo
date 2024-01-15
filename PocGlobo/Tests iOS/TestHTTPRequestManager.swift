//
//  HTTPRequestManager.swift
//  Tests iOS
//
//  Created by Alessandro Teixeira Lima on 14/01/24.
//

import XCTest

@testable import PocGlobo

class TestHTTPRequestManager: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
    func testMakePostRequestSuccess() {
            let expectation = XCTestExpectation(description: "HTTP Request Expectation")

            let jsonBody = """
                {
                    "key": "value"
                }
            """.data(using: .utf8)!

            let manager = HTTPRequestManager()

            manager.makePostRequest(with: jsonBody) { result in
                switch result {
                case .success(let success):
                    XCTAssertTrue(success, "Request should be successful")
                case .failure(let error):
                    XCTFail("Unexpected failure: \(error)")
                }

                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 10.0)
        }

        func testMakePostRequestInvalidResponse() {
            let expectation = XCTestExpectation(description: "HTTP Request Expectation")

            // Provide invalid JSON data
            let jsonBody = "Invalid JSON".data(using: .utf8)!

            let manager = HTTPRequestManager()

            manager.makePostRequest(with: jsonBody) { result in
                switch result {
                case .success:
                    XCTFail("Request should not be successful with invalid response")
                case .failure(let error):
                    XCTAssertEqual(error, .invalidResponse, "Error should be .invalidResponse")
                }

                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 10.0)
        }

        func testMakePostRequestTimeout() {
            let expectation = XCTestExpectation(description: "HTTP Request Expectation")

            // Use an empty JSON body to simulate a long-running request
            let jsonBody = Data()

            let manager = HTTPRequestManager()

            manager.makePostRequest(with: jsonBody) { result in
                switch result {
                case .success:
                    XCTFail("Request should not be successful with timeout")
                case .failure(let error):
                    XCTAssertEqual(error, .timeout, "Error should be .timeout")
                }

                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 10.0)
        }

}
