# Salonguru Shop

The Salonguru Shop App is a Flutter-based proof-of-concept application. It demonstrates the integration of a shopping feature that allows users to browse products, add them to a shopping cart, and make purchases.

https://github.com/user-attachments/assets/df626b8e-a921-478a-84f4-988235c70070

## How To Run the App 

Follow these steps to set up and contribute to the project:

Flutter version: **3.24.5**

1. **Clone the Repository**
   
   ```bash
   git clone 
2. **Install Dependencies**
   
   ```bash
   flutter pub get
3. **Run the app**

   ```bash
   flutter run

## Test
This app includes comprehensive testing with two types of tests: widget tests and unit tests. The implemented tests cover various aspects, including data sources, BLoC, extensions, states, and core business logic.

## Folder Structure
This project follows the Clean Code Architecture integrated with Bloc State Management for efficient and scalable application development.
The detailed code structure is outlined below:

```plaintext
lib/
├── core/                         # Contains shared code used across the app.
│   ├── constants/                # Defines app-wide constants, such as strings, and other static values.
│   ├── enums/                    # Contains enumerations used for categorization or state management.
│   ├── extensions/               # Provides custom Dart extensions to add utility methods to existing classes.
│   ├── local_storage/            # Handles local storage logic
│   ├── service_locator/          # Contains the service locator for dependency injection.
│   ├── shared_widget/            # Houses reusable widgets that are shared across multiple features.
│   ├── utils/                    # Utility functions, such as date parsers, formatters, or custom validators.
├── features/                     # Contains the implementation of app features, structured modularly.
│   ├── feature_name/             # Placeholder for a specific feature's code.
│   │   ├── data/                 # Contains data-related code for the feature.
│   │   │   ├── datasources/      # Defines remote and local data sources (e.g., APIs, databases).
│   │   │   ├── models/           # Data models that map JSON responses or database entities.
│   │   │   └── repositories/     # Implements the domain's repository contracts for data management.
│   │   ├── domain/               # Contains business logic and definitions for the feature.
│   │   │   ├── entities/         # Core business objects with only essential fields and properties.
│   │   │   ├── repositories/     # Abstract definitions of the repositories used by the domain layer.
│   │   │   └── use_case/         # Encapsulates specific business logic for the feature.
│   │   └── presentation/         # Handles UI and state management for the feature.
│   │       ├── bloc/             # Bloc files for state management (events, states, blocs).
│   │       ├── pages/            # Flutter screens/pages for this feature.
│   │       └── widgets/          # Reusable UI widgets specific to the feature.
├── app.dart                      # Main app widget that initializes and configures the app.
└── main.dart                     # Application entry point, contains the `main()` function.
```
