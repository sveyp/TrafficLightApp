Traffic Light System Exercise

This project implements a traffic light system using SwiftUI and MVVM architecture as part of an interview exercise. It consists of two screens:
	•	Car Model Screen:
    A screen that prompts the user to enter their car model (minimum 3 characters) and validates the input.
    Upon valid entry, it navigates to the second screen.
	•	Traffic Light Screen:
    A screen displaying the car model and a vertical traffic light.
    The traffic light cycles through red, orange, and green with specified durations and fade animations.
    The user can pause/resume the cycle.

Project Structure
	•	Modules:
	  •	CarModelScreen contains the views and view models for car model input.
	  •	TrafficLightScreen contains the views and view models for the traffic light functionality.
	•	Constants:
    All styling and string constants have been extracted into dedicated files for maintainability.
	•	Testing:
    Unit tests verify both the validation logic in the car model view model and the timer-based traffic light cycle.
