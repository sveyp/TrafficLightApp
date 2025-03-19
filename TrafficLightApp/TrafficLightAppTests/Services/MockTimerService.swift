//
//  MockTimerService.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

import Foundation
@testable import TrafficLightApp

/**
 A mock implementation of `TimerServiceProtocol` for unit testing.
 
 - Records scheduled intervals in `scheduledIntervals` so you can assert the view model is scheduling the correct durations.
 - Optionally fires the block immediately if `shouldFireImmediately` is true (but only for the first schedule to avoid infinite recursion).
 - Tracks invalidation in `isTimerInvalidated` so you can verify the timer is invalidated when expected.
 - Stores the last scheduled timer block in `lastScheduledBlock` for manual triggering.
 */
class MockTimerService: TimerServiceProtocol {
    private(set) var scheduledIntervals: [TimeInterval] = []
    private(set) var isTimerInvalidated = false
    
    /// If true, automatically fires the timer callback when scheduling (only for the first schedule to avoid infinite loops).
    var shouldFireImmediately = true
    
    /// The last scheduled timer block, stored for manual triggering in tests.
    var lastScheduledBlock: (() -> Void)?
    
    func scheduleTimer(withTimeInterval interval: TimeInterval, block: @escaping () -> Void) {
        scheduledIntervals.append(interval)
        lastScheduledBlock = block
        // To avoid infinite loops, only fire immediately on the very first call
        if shouldFireImmediately && scheduledIntervals.count == 1 {
            block()
        }
    }
    
    func invalidateTimer() {
        isTimerInvalidated = true
    }
}
