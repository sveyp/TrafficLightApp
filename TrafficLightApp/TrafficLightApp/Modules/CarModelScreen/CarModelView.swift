//
//  CarModelView.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 18.03.25.
//

import SwiftUI

struct CarModelView: View {
    @StateObject private var viewModel = CarModelViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: TrafficLightStyles.Spacing.spacing20) {
                    Text(Constants.Titles.enterCarModel)
                        .font(.headline)
                        .accessibilityLabel(Constants.AccessibilityLabels.carModelInputField)

                    TextField(Constants.TextFieldPlaceholders.carModelPlaceholder, text: $viewModel.carModel)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: TrafficLightStyles.CornerRadius.radius5)
                                .stroke(viewModel.showError
                                        ? TrafficLightStyles.Colors.activeRed
                                        : TrafficLightStyles.Colors.inactive,
                                        lineWidth: 1)
                        )
                        .accessibilityLabel(Constants.AccessibilityLabels.carModelInput)
                        .onChange(of: viewModel.carModel) {
                            viewModel.validateInput()
                        }
                        .onSubmit {
                            viewModel.validateAndNavigate()
                        }
                    
                    if viewModel.showError {
                        Text(Constants.ErrorMessages.invalidCarModel)
                            .foregroundColor(TrafficLightStyles.Colors.activeRed)
                            .font(.caption)
                            .padding(.top, TrafficLightStyles.Padding.negativePadding)
                            .accessibilityLabel("Error: \(Constants.ErrorMessages.invalidCarModel)")
                    }
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    viewModel.validateAndNavigate()
                }) {
                    Text(Constants.ButtonTitles.startDriving)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.carModel.count >= 3
                                    ? TrafficLightStyles.Colors.defaultButton
                                    : TrafficLightStyles.Colors.inactive)
                        .foregroundColor(.white)
                        .cornerRadius(TrafficLightStyles.CornerRadius.radius10)
                }
                .disabled(viewModel.carModel.count < 3)
                .padding()
                .accessibilityLabel(Constants.AccessibilityLabels.startDrivingButton)
            }
            .navigationDestination(isPresented: $viewModel.isNavigating) {
                TrafficLightView(carModel: viewModel.carModel)
            }
        }
    }
}

#Preview {
    CarModelView()
}
