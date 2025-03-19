//
//  TrafficLightViewModel.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

import Foundation

class TrafficLightViewModel: TrafficLightViewModelProtocol {
    
    // MARK: - Properties
    @Published var activeLight: TrafficLight = .red
    @Published var isPaused: Bool = false

    private var timerService: TimerServiceProtocol
    private var goingUp: Bool = false
    
    // MARK: - Intializer
    init(timerService: TimerServiceProtocol = DefaultTimerService()) {
        self.timerService = timerService
    }
    
    deinit {
        timerService.invalidateTimer()
    }
    
    // MARK: - TrafficLightViewModelProtocol
    func startTrafficLightCycle() {
        timerService.invalidateTimer()
        holdCurrentLight()
    }
    
    func pauseCycle() {
        isPaused = true
        timerService.invalidateTimer()
    }
    
    func resumeCycle() {
        isPaused = false
        holdCurrentLight()
    }
    
    // MARK: - Private Methods
    private func holdCurrentLight() {
        guard !isPaused else { return }
        
        let duration: TimeInterval
        
        switch activeLight {
        case .red:
            duration = 4
        case .orange:
            duration = 1
        case .green:
            duration = 4
        }
        
        restartTimer(after: duration)
    }
    
    private func switchLight() {
        guard !isPaused else { return }
        
        switch activeLight {
        case .red:
            activeLight = .orange
            goingUp = true
        case .orange:
            activeLight = goingUp ? .green : .red
        case .green:
            activeLight = .orange
            goingUp = false
        }
        
        holdCurrentLight()
    }
    
    private func restartTimer(after interval: TimeInterval) {
        timerService.invalidateTimer()
        timerService.scheduleTimer(withTimeInterval: interval) { [weak self] in
            self?.switchLight()
        }
    }
}
