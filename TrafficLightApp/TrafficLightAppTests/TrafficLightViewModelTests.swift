//
//  TrafficLightViewModelTests.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//


import XCTest
@testable import TrafficLightApp

final class TrafficLightViewModelTests: XCTestCase {
    
    var viewModel: TrafficLightViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = TrafficLightViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    /// Test that the initial state is red.
    func testInitialActiveLight() {
        XCTAssertEqual(viewModel.activeLight, .red, "The initial active light should be red.")
    }
    
    /// Test that pauseCycle() sets isPaused to true.
    func testPauseCycle() {
        viewModel.pauseCycle()
        XCTAssertTrue(viewModel.isPaused, "Traffic light should be paused after calling pauseCycle().")
    }
    
    /// Test that resumeCycle() sets isPaused to false.
    func testResumeCycle() {
        viewModel.pauseCycle()
        viewModel.resumeCycle()
        XCTAssertFalse(viewModel.isPaused, "Traffic light should resume (isPaused false) after calling resumeCycle().")
    }
    
    /// Test that the cycle eventually switches from red.
    /// Note: Because the cycle uses timers, we use an expectation to wait for the change.
    func testTrafficLightCycle() {
        let expectation = XCTestExpectation(description: "Traffic light cycles away from red")
        
        viewModel.startTrafficLightCycle()
        
        // We wait for 5 seconds, knowing that red holds for 4 seconds before switching.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotEqual(self.viewModel.activeLight, .red, "After 5 seconds, the active light should have changed from red.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 6)
    }
}
