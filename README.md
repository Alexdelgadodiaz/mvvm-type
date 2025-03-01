# MVVM-Type: Sport Shooting App

## Overview
This is an iOS application using the MVVM (Model-View-ViewModel) architecture. The project is structured into different layers for organization and maintainability.

## Project Structure

### Models (`sport-shooting/Models/`)
- Defines the data structures used in the app.
- Examples: `User.swift`, `Item.swift`.

### ViewModels (`sport-shooting/Views/...ViewModel.swift`)
- Handles business logic and communicates with Services.
- Exposes observable properties for UI updates.
- Examples: `LoginViewModel.swift`, `ItemListViewModel.swift`.

### Views (`sport-shooting/Views/`)
- Implements SwiftUI UI components.
- Uses `@StateObject` and `@EnvironmentObject` to interact with ViewModels.
- Examples: `LoginView.swift`, `ItemListView.swift`.

### Services (`sport-shooting/Services/`)
- Manages data and networking.
- Implements protocols for abstraction and testability.
- Examples: `AuthService.swift`, `ItemService.swift`.

### Utilities (`sport-shooting/Utilities/`)
- Contains helper functions and network configurations.
- Examples: `NetworkClient.swift`, `HTTPMethod.swift`.

### Testing (`sport-shootingTests/` & `sport-shootingUITests/`)
- Unit tests for ViewModels (`LoginViewModelTests.swift`).
- UI tests for basic app flow (`sport_shootingUITests.swift`).

## Running the Project
1. Clone the repository:
   ```bash
   git clone <repo_url>
   ```
2. Open the `.xcworkspace` in Xcode.
3. Run the project on the simulator or a real device.

## Features
- MVVM Architecture
- Dependency Injection (`AppDependencyContainer.swift`)
- Networking with `NetworkClient.swift`
- Unit & UI Testing
- SwiftUI-based UI

The project is structured to separate concerns and keep things manageable.

