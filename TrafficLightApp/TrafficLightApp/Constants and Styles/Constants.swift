//
//  Constants.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

enum Constants {
    
    enum Titles {
        static let carTitlePrefix = "Car: "
        static let enterCarModel = "Enter your car model:"
    }
    
    enum ButtonTitles {
        static let startDriving = "Start Driving"
        static let pause = "Pause"
        static let resume = "Resume"
    }
    
    enum ErrorMessages {
        static let invalidCarModel = "Car model must be at least 3 characters long"
    }
    
    enum TextFieldPlaceholders {
        static let carModelPlaceholder = "Car Model (Min. 3 characters)"
    }
    
    enum AccessibilityLabels {
        static func carModel(_ model: String) -> String {
            "Car Model: \(model)"
        }
        static let carModelInput = "Car Model Input"
        static let carModelInputField = "Car Model Input Field"
        static let startDrivingButton = "Start Driving Button"
        static let redLight = "Red Light"
        static let orangeLight = "Orange Light"
        static let greenLight = "Green Light"
        static func trafficLightButton(isPaused: Bool) -> String {
            isPaused ? "Resume Traffic Light" : "Pause Traffic Light"
        }
    }
}
