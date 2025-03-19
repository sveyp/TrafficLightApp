//
//  CarModelViewModelTests.swift
//  TrafficLightApp
//
//  Created by Svetlomir Petrov on 19.03.25.
//

import XCTest
@testable import TrafficLightApp

final class CarModelViewModelTests: XCTestCase {
    
    var viewModel: CarModelViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = CarModelViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    /// Test that a short car model (less than 3 characters) triggers an error.
    func testValidateInput_withShortInput_showsError() {
        // Given: A car model with fewer than 3 characters.
        viewModel.carModel = "ab"
        
        // When: Validation is performed.
        viewModel.validateInput()
        
        // Then: showError should be true.
        XCTAssertTrue(viewModel.showError, "Expected showError to be true for input less than 3 characters.")
    }
    
    /// Test that a valid car model (3 or more characters) does not trigger an error.
    func testValidateInput_withValidInput_noError() {
        // Given: A car model with 3 or more characters.
        viewModel.carModel = "abc"
        
        // When: Validation is performed.
        viewModel.validateInput()
        
        // Then: showError should be false.
        XCTAssertFalse(viewModel.showError, "Expected showError to be false for input with 3 or more characters.")
    }
    
    /// Test validateAndNavigate with invalid input: it should set showError to true and not trigger navigation.
    func testValidateAndNavigate_withInvalidInput() {
        // Given: An invalid car model (less than 3 characters).
        viewModel.carModel = "ab"
        
        // When: validateAndNavigate is called.
        viewModel.validateAndNavigate()
        
        // Then: showError should be true and navigation should not be triggered.
        XCTAssertTrue(viewModel.showError, "Expected showError to be true for invalid input.")
        XCTAssertFalse(viewModel.isNavigating, "Expected isNavigating to be false when input is invalid.")
    }
    
    /// Test validateAndNavigate with valid input: it should clear errors and trigger navigation.
    func testValidateAndNavigate_withValidInput() {
        // Given: A valid car model (3 or more characters).
        viewModel.carModel = "Toyota"
        
        // When: validateAndNavigate is called.
        viewModel.validateAndNavigate()
        
        // Then: showError should be false and navigation should be triggered.
        XCTAssertFalse(viewModel.showError, "Expected showError to be false for valid input.")
        XCTAssertTrue(viewModel.isNavigating, "Expected isNavigating to be true when input is valid.")
    }
}
