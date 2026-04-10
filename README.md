# BlogHub

BlogHub is a full-stack Flutter blogging application built to demonstrate production-style mobile app development using Clean Architecture, BLoC state management, and offline-first data handling.

## Overview

The app supports secure user authentication, blog publishing with image uploads, topic-based organization, and a responsive reading experience with caching support. It was designed with a feature-first structure so each module stays isolated, testable, and easy to scale.

Demo: https://www.linkedin.com/posts/nithil-sheshan-4a3945210_flutter-dart-cleanarchitecture-activity-7448414039908462594-0prr?utm_source=share&utm_medium=member_desktop&rcm=ACoAADWIVHsBQyvJg7MFpZpjndpUXN6v4s4fnlE

## Key Features

- Secure sign up, login, session restoration, and sign out
- Blog creation with cover image upload and custom topic selection
- Latest-first blog feed with pull-to-refresh support
- Detailed blog viewer with author info, date formatting, and reading-time estimation
- Theme switching with persistent user preference
- Offline-friendly reading through local Hive cache fallback
- Connectivity-aware error handling and snackbar feedback
- Modular UI with reusable widgets, loaders, and shimmer states

## Tech Stack

- Flutter and Dart
- BLoC / Cubit for state management
- Supabase for authentication, PostgreSQL access, and storage
- Hive for local persistence and offline caching
- GetIt for dependency injection
- fpdart for functional error handling with Either
- image_picker for cover image selection
- intl for date formatting
- internet_connection_checker_plus for network awareness
- flutter_dotenv for environment-based configuration

## Architecture

BlogHub follows a feature-first Clean Architecture structure:

- Presentation layer: UI, pages, widgets, BLoC/Cubit
- Domain layer: entities, repository contracts, use cases
- Data layer: remote data sources, local data sources, repository implementations

This separation keeps business logic independent from UI and infrastructure, which improves maintainability, testability, and long-term scalability.

## Patterns and Best Practices

- Clean Architecture with clear layer boundaries
- Repository pattern for data abstraction
- Use Case pattern for business operations
- Offline-first read strategy with remote-to-local caching
- Dependency injection with centralized service registration
- Feature-based modularization
- Functional error handling with explicit success/failure flows
- Shared theme system for consistent UI behavior

## Screenshots

### Authentication
![Login and SignUp](assets/screenshots/Login%20and%20SignUp.png)

### Home and Blog View
![HomeScreen and Blog View](assets/screenshots/HomeScreen%20and%20Blog%20View.png)

### Blog Creation, Theme Toggle, and Sign Out
![Blog Creation and Theme Toggle and Signout](assets/screenshots/Blog%20Creation%20and%20Theme%20Toggle%20and%20Signout.png)

## What This Project Demonstrates

This project reflects practical knowledge of Flutter app architecture, state orchestration, backend integration, local caching, reusable component design, and building a maintainable mobile codebase with industry-style structure.
