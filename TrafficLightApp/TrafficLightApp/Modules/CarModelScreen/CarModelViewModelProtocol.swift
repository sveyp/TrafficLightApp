//
//  CarModelViewModelProtocol.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

import SwiftUI

protocol CarModelViewModelProtocol: ObservableObject {
    /// The car model entered by the user.
    var carModel: String { get }
    
    /// A flag indicating if the car model input is invalid.
    var showError: Bool { get }
    
    /// A flag that triggers navigation to the next screen.
    var isNavigating: Bool { get }
    
    /// Validates the car model input. Sets `showError` to true if the input is less than 3 characters.
    func validateInput()
    
    /// Validates the car model input and triggers navigation if valid.
    func validateAndNavigate()
}
