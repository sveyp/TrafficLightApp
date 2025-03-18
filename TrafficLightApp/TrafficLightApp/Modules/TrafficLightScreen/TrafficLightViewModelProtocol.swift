//
//  TrafficLightViewModelProtocol.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

import SwiftUI

protocol TrafficLightViewModelProtocol: ObservableObject {
    
    /// The currently active traffic light color.
    var activeLight: TrafficLight { get }
    
    /// Indicates if the traffic light cycle is paused.
    var isPaused: Bool { get }
    
    /// Starts the traffic light cycle.
    func startTrafficLightCycle()
    
    /// Pauses the traffic light cycle.
    func pauseCycle()
    
    /// Resumes the traffic light cycle.
    func resumeCycle()
}
