//
//  DefaultTimerServiceTests.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

import XCTest
@testable import TrafficLightApp

final class DefaultTimerServiceTests: XCTestCase {
    
    var timerService: DefaultTimerService!
    
    override func setUp() {
        super.setUp()
        
        timerService = DefaultTimerService()
    }
    
    override func tearDown() {
        timerService.invalidateTimer()
        timerService = nil
        
        super.tearDown()
    }
    
    /// Tests that the timer fires after approximately the specified interval.
    func testScheduleTimer_firesAfterInterval() {
        // Given: A timer scheduled to fire after 1 second.
        let expectation = self.expectation(description: "Timer fired after 1 second")
        let start = Date()
        
        // When: The timer is scheduled.
        timerService.scheduleTimer(withTimeInterval: 1.0) {
            // Then: The timer should fire after approximately 1 second.
            let elapsed = Date().timeIntervalSince(start)
            XCTAssertTrue(elapsed >= 1.0, "Timer should fire after ~1 second, fired after \(elapsed) seconds")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    /// Tests that invalidating the timer prevents the callback from being fired.
    func testInvalidateTimer() {
        // Given: A timer scheduled to fire after 1 second.
        let expectation = self.expectation(description: "Timer should not fire after invalidation")
        timerService.scheduleTimer(withTimeInterval: 1.0) {
            // Then: The timer callback should not be called because it will be invalidated.
            XCTFail("Timer callback should not have fired because it was invalidated.")
        }
        
        // When: The timer is invalidated immediately.
        timerService.invalidateTimer()
        
        // Then: Wait a bit longer than the scheduled interval to ensure the callback is not fired.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
