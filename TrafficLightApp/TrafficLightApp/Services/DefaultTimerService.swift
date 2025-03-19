//
//  DefaultTimerService.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

import Foundation

class DefaultTimerService: TimerServiceProtocol {
    private var timer: Timer?
    
    func scheduleTimer(withTimeInterval interval: TimeInterval, block: @escaping () -> Void) {
        invalidateTimer()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            DispatchQueue.main.async {
                block()
            }
        }
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}
