//
//  TrafficLightView.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

import SwiftUI

struct TrafficLightView: View {
    @StateObject private var viewModel = TrafficLightViewModel()
    let carModel: String
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Text("Car: \(carModel)")
                    .font(.title)
                    .padding()
                    .accessibilityLabel("Car Model: \(carModel)")
                
                VStack(spacing: 10) {
                    TrafficLightCircle(color: .red, isActive: viewModel.activeLight == .red)
                        .accessibilityLabel("Red Light")
                    
                    TrafficLightCircle(color: .orange, isActive: viewModel.activeLight == .orange)
                        .accessibilityLabel("Orange Light")
                    
                    TrafficLightCircle(color: .green, isActive: viewModel.activeLight == .green)
                        .accessibilityLabel("Green Light")
                }
                .frame(height: 350)
                .padding(.top, 20)
                
                Spacer()
            }
            
            VStack(spacing: 15) {
                Button(action: {
                    if viewModel.isPaused {
                        viewModel.resumeCycle()
                    } else {
                        viewModel.pauseCycle()
                    }
                }) {
                    Text(viewModel.isPaused ? "Resume" : "Pause")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isPaused ? Color.green.opacity(0.7) : Color.red.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .accessibilityLabel(viewModel.isPaused ? "Resume Traffic Light" : "Pause Traffic Light")
            }
            .padding()
        }
        .onAppear {
            viewModel.startTrafficLightCycle()
        }
    }
}

struct TrafficLightCircle: View {
    let color: Color
    let isActive: Bool
    
    var body: some View {
        Circle()
            .fill(color.opacity(isActive ? 1.0 : 0.2))
            .frame(width: 100, height: 100)
            .animation(.easeInOut(duration: 0.5), value: isActive)
    }
}

#Preview {
    TrafficLightView(carModel: "Toyota")
}
