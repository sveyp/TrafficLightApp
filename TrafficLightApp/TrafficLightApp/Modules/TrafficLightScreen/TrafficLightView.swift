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
            VStack(spacing: TrafficLightStyles.Spacing.spacing20) {
                Text("\(Constants.Titles.carTitlePrefix) \(carModel)")
                    .font(.title)
                    .padding()
                    .accessibilityLabel(Constants.AccessibilityLabels.carModel(carModel))
                
                VStack(spacing: TrafficLightStyles.Spacing.spacing10) {
                    TrafficLightCircle(color: TrafficLightStyles.Colors.activeRed,
                                       isActive: viewModel.activeLight == .red)
                    .accessibilityLabel(Constants.AccessibilityLabels.redLight)
                    
                    TrafficLightCircle(color: TrafficLightStyles.Colors.activeOrange,
                                       isActive: viewModel.activeLight == .orange)
                    .accessibilityLabel(Constants.AccessibilityLabels.orangeLight)
                    
                    TrafficLightCircle(color: TrafficLightStyles.Colors.activeGreen,
                                       isActive: viewModel.activeLight == .green)
                    .accessibilityLabel(Constants.AccessibilityLabels.greenLight)
                }
                .frame(height: TrafficLightStyles.Frame.trafficLightStackHeight)
                .padding(.top, TrafficLightStyles.Padding.padding20)
                
                Spacer()
            }
            
            VStack(spacing: TrafficLightStyles.Spacing.spacing15) {
                Button(action: {
                    if viewModel.isPaused {
                        viewModel.resumeCycle()
                    } else {
                        viewModel.pauseCycle()
                    }
                }) {
                    Text(viewModel.isPaused
                         ? Constants.ButtonTitles.resume
                         : Constants.ButtonTitles.pause)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isPaused
                                    ? TrafficLightStyles.Colors.greenButtonWithOpacity
                                    : TrafficLightStyles.Colors.redButtonWithOpacity)
                        .foregroundColor(.white)
                        .cornerRadius(TrafficLightStyles.CornerRadius.radius10)
                }
                .accessibilityLabel(Constants.AccessibilityLabels.trafficLightButton(isPaused: viewModel.isPaused))
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
            .frame(width: TrafficLightStyles.Frame.circleSize,
                   height: TrafficLightStyles.Frame.circleSize)
            .animation(.easeInOut(duration: TrafficLightStyles.Animation.easeInOutDuration),
                       value: isActive)
    }
}

#Preview {
    TrafficLightView(carModel: "Toyota")
}
