# Diário de Sono

This project is a solution for the **Flutter Developer Technical Challenge** by Condor Instruments. It consists of a Sleep Diary mobile application.

The app is designed to help users track their nightly habits, receive daily reminders to fill out their sleep logs, and export their recorded data. It aims to simulate a real-world feature set close to the company's products, showcasing solid development practices in Flutter.

This documentation covers the project's structure, design patterns, and how modern Flutter architecture principles have been implemented to create a modular, testable, and maintainable codebase.

## Key Features

* **Daily Sleep Logging**: Users can record the time they went to bed, sleep latency, total sleep duration, and the number of awakenings.
* **Daily Reminder Notifications**: Local notifications remind users at a fixed time each day to complete their sleep diary.
* **Persistent Local Storage**: All data is stored locally on the device using a technology of choice (e.g., Hive, SQLite, SharedPreferences).
* **Data Export**: Users can export their sleep data in CSV or JSON formats and share it via email, messaging apps, etc.
* **Bonus Features (Optional)**: Historical data visualization with charts, aggregate statistics (mean, min, max, standard deviation), and customizable reminder times.

## Technology

### Required Versions

* **Dart**: [![Dart][dart_img]][dart_ln] [Official Dart Documentation](https://dart.dev)

* **Flutter**: [![Flutter][flutter_img]][flutter_ln] [Official Flutter Documentation](https://docs.flutter.dev/get-started/install)

### Main Packages Used

* [Auto Injector](https://pub.dev/packages/auto_injector): Dependency injection in the app
* [SQLite](https://pub.dev/packages/sqflite): Persistent Local Storage
* [Share Plus](https://pub.dev/packages/share_plus): Platform's share dialog

## Usage

To start the project, use the following command:

```sh
flutter run -t lib/main.dart
```

### Running Tests

To test unit report:

```sh
flutter test
```

### Running tests with coverage

To generate a coverage report:

```sh
flutter test --coverage
```

To view coverage results in an HTML report:

```sh
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html  # macOS
xdg-open coverage/html/index.html  # Linux
start coverage/html/index.html  # Windows
```

## Documentation

### Why We Chose SQLite

For this project, we selected **SQLite** as our local persistence solution over alternatives like **Hive** or **SharedPreferences**, based on the need to efficiently handle a relatively large volume of sleep diary records with flexible filtering.

While **SharedPreferences** and **Hive** can both be used to store structured lists by serializing data with formats such as JSON, they do not provide native query support. Both approaches require loading the entire dataset into memory and filtering it using Dart code, which becomes less efficient as the number of records increases. **Hive** remains a very fast and developer-friendly NoSQL solution for smaller or simpler datasets. However, for larger volumes of data with more advanced filtering needs, an embedded SQL engine.

**SQLite** was chosen because it is a mature, relational database that excels at:

* Managing large datasets with excellent performance.
* Supporting advanced filtering, sorting, and pagination natively through SQL queries.
* Enabling persistent, structured data storage with well-defined schemas.

This choice ensures the app can scale gracefully while providing users with fast when filtering by specific criteria or exporting selected subsets of data.

### State Management & App Architecture

Our project follows the architecture recommended by the Flutter team, based on the **Model–View–ViewModel (MVVM)** pattern combined with a **state management system** built atop Flutter’s `ChangeNotifier` and `Listenable` mechanisms.

#### Why MVVM and `ChangeNotifier`

* **Clear separation of concerns**: We structure the app into **View**, **ViewModel**, **Repository**, and **Service** layers. Views handle UI rendering and user events, ViewModels encapsulate UI logic and state, and repositories/services manage data sources.
* **Scalable UI logic**: Each View leverages a corresponding ViewModel that transforms raw model data into a format ready for display. The ViewModel exposes reactive state and commands, ensuring views remain stateless and declarative.
* **Reactive state updates**: We rely on `ChangeNotifier` and `ValueNotifier` (wrapped with `ListenableBuilder` or `ChangeNotifierProvider`) to notify views of state changes. This aligns with Flutter’s native reactive patterns and simplifies rebuild logic.

#### How It Works

1. **Views**: Compose UI elements and subscribe to ViewModel state. They delegate user interactions (such as button taps or form input) to ViewModel methods.
2. **ViewModels**: Fetch and format data from repositories, maintain local flags (loading, error, etc.), and define command functions that the View can invoke. They notify listeners when data or state changes.
3. **Repositories & Services**: Handle raw data access—whether from SQLite, local storage, or external APIs—abstracting these concerns away from the ViewModel .

### Integrating `result_dart` & `result_command` with MVVM Commands

Following Flutter’s app architecture guidance which recommends using a Result type in Command implementations for clearer handling of success and error in MVVM, we adopted the `result_dart` package along with `result_command`. This combination strengthens our Command layer and aligns with official best practices.

---

#### `result_dart`

* Provides a `Result<S, F>` type inspired by Kotlin and Swift, encapsulating successful and failure outcomes.
* Encourages reducing `try/catch` usage by centralizing result logic and error propagation.
* Offers useful methods such as `fold`, `getOrNull`, `map`, and `flatMap` for clean and expressive handling of operation results.

#### `result_command`

* Builds on `result_dart` to implement the Command pattern in Flutter and Dart.
* Supports `Command0`, `Command1`, and `Command2` depending on the number of parameters
* Manages execution state (Idle, Running, Success, Failure, Cancelled), provides timeout and cancellation features, and maintains history.
* They are `Listenable`, support state checks (`isRunning`, `isSuccess`, etc.), and enable UI integration via `ValueListenableBuilder` or listeners.

---

#### How They Work Together

By combining our MVVM architecture with these packages:

1. **ViewModels** expose `Command` objects for user actions (e.g., loading entries, exporting data).
2. Each `Command` executes business logic and returns a `Result` type using `result_dart`.
3. `result_command` wraps these operations, managing states like **Idle**, **Running**, **Success**, **Failure**, and supports cancellation/timeouts.
4. The UI reacts to command state changes (e.g., showing loading indicators, handling errors or successful outcomes).

#### Benefits of This Approach

* Clear **separation of concerns**: ViewModels focus on app logic, while Commands manage execution flow and results.
* **Expressive error handling**: Errors and results are handled via structured `Result`, avoiding scattered exception handling.
* **Reactive UI patterns**: State changes flow naturally to the UI using Flutter’s `Listenable` mechanisms.
* **Type safety and predictability**: Developers are forced to handle both success and failure paths, reducing runtime surprises.

<!-- Useful links: -->
[dart_img]: https://img.shields.io/static/v1?label=Dart&message=3.8.1&color=blue&logo=dart
[dart_ln]: https://dart.dev/ "https://dart.dev/"
[flutter_img]: https://img.shields.io/static/v1?label=Flutter&message=3.32.5&color=blue&logo=flutter
[flutter_ln]: https://docs.flutter.dev/get-started/install "https://docs.flutter.dev/get-started/install"
