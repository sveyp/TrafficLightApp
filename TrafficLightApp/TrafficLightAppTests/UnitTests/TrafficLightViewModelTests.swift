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
    var mockTimerService: MockTimerService!
    
    override func setUp() {
        super.setUp()
        
        mockTimerService = MockTimerService()
        viewModel = TrafficLightViewModel(timerService: mockTimerService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockTimerService = nil
        
        super.tearDown()
    }
    
    func testInitialActiveLight() {
        // Given: Already configured in SetUp.
        // When: No action is taken.
        // Then: The active light should be red.
        XCTAssertEqual(viewModel.activeLight, .red, "The initial active light should be red.")
    }
    
    func testStartTrafficLightCycle_schedulesTimer() {
        // Given: A fresh instance and auto-firing disabled to prevent recursion.
        mockTimerService.shouldFireImmediately = false
        
        // When: The traffic light cycle is started.
        viewModel.startTrafficLightCycle()
        
        // Then: A timer should be scheduled once with a 4-second interval for the initial red light.
        XCTAssertEqual(mockTimerService.scheduledIntervals.count, 1, "Should schedule a timer once.")
        XCTAssertEqual(mockTimerService.scheduledIntervals.first, 4, "Initial red light should be 4 seconds.")
    }
    
    func testPauseCycle_invalidatesTimer() {
        // Given: The traffic light cycle is running.
        viewModel.startTrafficLightCycle()
        
        // When: The cycle is paused.
        viewModel.pauseCycle()
        
        // Then: The timer should be invalidated.
        XCTAssertTrue(mockTimerService.isTimerInvalidated, "Timer should be invalidated when paused.")
    }
    
    func testResumeCycle_reschedulesTimer() {
        // Given: The traffic light cycle was started and then paused.
        viewModel.startTrafficLightCycle()
        viewModel.pauseCycle()
        let previousCount = mockTimerService.scheduledIntervals.count
        
        // When: The cycle is resumed.
        viewModel.resumeCycle()
        
        // Then: A new timer should be scheduled (i.e. scheduledIntervals count increases).
        XCTAssertTrue(mockTimerService.scheduledIntervals.count > previousCount, "Should schedule a new timer when resuming.")
    }
    
    func testCycleSwitchesLightImmediately() {
        // Given: Auto-firing is disabled for manual control and the cycle is started.
        mockTimerService.shouldFireImmediately = false
        viewModel.startTrafficLightCycle()
        
        // Then: Initially, the active light should be red.
        XCTAssertEqual(viewModel.activeLight, .red, "Initial state should be red.")
        
        // When: Manually trigger the timer block.
        mockTimerService.lastScheduledBlock?()
        // Then: The light should switch from red to orange.
        XCTAssertEqual(viewModel.activeLight, .orange, "Should switch from red to orange after one cycle.")
        
        // When: Trigger the next timer block.
        mockTimerService.lastScheduledBlock?()
        // Then: The light should switch from orange to green.
        XCTAssertEqual(viewModel.activeLight, .green, "Should switch from orange to green.")
        
        // When: Trigger the next timer block.
        mockTimerService.lastScheduledBlock?()
        // Then: The light should switch from green to orange.
        XCTAssertEqual(viewModel.activeLight, .orange, "Should switch from green to orange.")
        
        // When: Trigger the next timer block.
        mockTimerService.lastScheduledBlock?()
        // Then: The light should switch from orange back to red, completing a full cycle.
        XCTAssertEqual(viewModel.activeLight, .red, "Should switch from orange back to red completing a full cycle.")
    }
}
