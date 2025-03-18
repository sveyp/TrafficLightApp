//
//  CarModelViewModel.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

import Foundation

class CarModelViewModel: CarModelViewModelProtocol {
    
    // MARK: - Properties
    @Published var carModel: String = ""
    @Published var showError: Bool = false
    @Published var isNavigating: Bool = false
    
    // MARK: - CarModelViewModelProtocol
    func validateInput() {
        showError = carModel.count < 3
    }
    
    func validateAndNavigate() {
        if carModel.count >= 3 {
            isNavigating = true
            showError = false
        } else {
            showError = true
        }
    }
}
