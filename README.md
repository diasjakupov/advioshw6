# Weather App for iOS

This iOS Weather application provides users with real-time weather data sourced from both the OpenWeatherMap API and WeatherAPI.com. The application efficiently handles concurrent data fetching, displays multiple weather data components, and ensures robust error handling and user feedback throughout the process.

## Features

- **Location-based Weather**: Allows users to search for and view weather information for different locations.
- **Concurrent Data Fetching**: Fetches and displays multiple weather data components simultaneously, including:
  - Current weather conditions
  - 5-day forecast
  - Astrology data (e.g., sunrise, sunset, moon phase)
  - Air quality index
  - Weather alerts and warnings
- **Real-Time Updates**: Displays data immediately as it is fetched, with visual indicators that reflect the current loading state.
- **Graceful Error Handling**: Includes error handling for network failures, incorrect data formats, and API errors.
- **Refresh Functionality**: Users can refresh weather data for a given location with a button press.

## Architecture

The application follows the MVVM (Model-View-ViewModel) architecture pattern, ensuring a clean separation of concerns:
- **Model**: Represents the data structures that contain weather-related information.
- **ViewModel**: Provides data to the View, including business logic and management of asynchronous tasks.
- **View**: Built with SwiftUI, the View reacts to state changes and displays weather data accordingly.

## Concurrency

The app utilizes Swift's structured concurrency to manage multiple concurrent weather data requests efficiently:
- **Task**: Used to create asynchronous tasks for fetching weather data without blocking the main thread.
- **TaskGroup**: Manages and runs multiple asynchronous tasks in parallel, ensuring the app remains responsive while fetching multiple weather data points.
- **async/await**: Enables non-blocking UI updates and smooth handling of asynchronous data fetching.



https://github.com/user-attachments/assets/bab92afd-93dc-49c7-86fe-095709399ff9



https://github.com/user-attachments/assets/294b1981-2b42-4b03-950a-f65bdddf5e8b



