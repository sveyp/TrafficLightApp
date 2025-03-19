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
                VStack(spacing: 20) {
                    Text("Enter your car model:")
                        .font(.headline)
                        .accessibilityLabel("Car Model Input Field")

                    TextField("Car Model (Min. 3 characters)", text: $viewModel.carModel)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(viewModel.showError ? Color.red : Color.gray, lineWidth: 1)
                        )
                        .accessibilityLabel("Car Model Input")
                        .onChange(of: viewModel.carModel) {
                            viewModel.validateInput()
                        }
                        .onSubmit {
                            viewModel.validateAndNavigate()
                        }
                    
                    if viewModel.showError {
                        Text("Car model must be at least 3 characters long")
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.top, -10)
                            .accessibilityLabel("Error: Car model must be at least 3 characters long.")
                    }
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    viewModel.validateAndNavigate()
                }) {
                    Text("Start Driving")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.carModel.count >= 3 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.carModel.count < 3)
                .padding()
                .accessibilityLabel("Start Driving Button")
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
