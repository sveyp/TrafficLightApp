//
//  TrafficLightStyles.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//
import SwiftUI

enum TrafficLightStyles {
    enum Colors {
        static let activeRed = Color.red
        static let activeOrange = Color.orange
        static let activeGreen = Color.green
        
        static let greenButtonWithOpacity: Color = .green.opacity(0.7)
        static let redButtonWithOpacity: Color = .red.opacity(0.7)
        static let defaultButton: Color = .blue

        static let inactive = Color.gray
    }
    
    enum Spacing {
        static let spacing20: CGFloat = 20
        static let spacing10: CGFloat = 10
        static let spacing15: CGFloat = 15
    }
    
    enum Padding {
        static let defaultPadding: CGFloat = 16
        static let padding20: CGFloat = 20
        static let negativePadding: CGFloat = -10
    }
    
    enum Frame {
        static let trafficLightStackHeight: CGFloat = 350
        static let circleSize: CGFloat = 100
    }
    
    enum Animation {
        static let easeInOutDuration: Double = 0.5
    }
    
    enum CornerRadius {
        static let radius10: CGFloat = 10
        static let radius5: CGFloat = 5
    }
}
