//
//  TimerServiceProtocol.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

import Foundation

protocol TimerServiceProtocol {
    /// Schedules a one-shot timer to fire after a given interval.
    /// - Parameters:
    ///   - interval: The delay (in seconds) before the timer fires.
    ///   - block: The block to execute when the timer fires.
    func scheduleTimer(withTimeInterval interval: TimeInterval, block: @escaping () -> Void)
    
    /// Invalidates the currently scheduled timer.
    func invalidateTimer()
}
