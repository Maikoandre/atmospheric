<div align="center">
  <h1>🌤️ Atmospheric</h1>
  <p><strong>An elegant, dynamic, and native Weather Application built with Flutter.</strong></p>
  <p>
    <a href="https://flutter.dev/"><img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter"></a>
    <a href="https://dart.dev/"><img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"></a>
    <a href="https://openweathermap.org/api"><img src="https://img.shields.io/badge/OpenWeather-API-orange?style=for-the-badge&logo=openweathermap" alt="OpenWeather API"></a>
  </p>
</div>

---

## 📖 Overview

**Atmospheric** is a sleek, dynamic weather application built with Flutter that delivers robust and granular weather forecasts. It intelligently consumes the OpenWeather API's free tier, dynamically transforming raw 3-hour forecasts into comprehensive, accurate predictive models for the entire week, bypassing premium restrictions with smart frontend aggregation.

Designed with modern UI/UX principles, Atmospheric features glassmorphism, fluid interactive sliders, and aesthetic bento-grid layouts to present complex telemetry data cleanly.

---

## ✨ Key Features

- **Real-Time Weather Telemetry:** Live updates on temperature, humidity, wind speed, pressure, and visibility.
- **Hourly Predictive Slider:** fluid timeline mapping out the weather for the next 24 hours.
- **Aggregated 5-Day Forecast:** Intelligent aggregation algorithm that processes 40 individual 3-hour API data points into seamless daily minimum/maximum extremes.
- **Location & Geocoding Integration:** Natively fetches system-level GPS coordinates and reverse-geocodes them into human-readable city names.
- **Bento Grid Layout:** Important weather metrics displayed in a modern, easily digestible grid format.
- **State-Preserving Navigation:** Utilizes an indexed stack routing approach to keep background processes alive while seamlessly switching views.
- **Environment Security:** API keys are protected through secure `.env` integration.

---

## 🏗️ Architecture & Project Structure

The project strictly adheres to a clean, service-oriented UI pattern common in highly scalable Flutter environments. It enforces separation of concerns by splitting algorithmic processing from widget rendering.

```text
atmospheric/
├── android/            # Android native project files
├── ios/                # iOS native project files
├── web/                # Web application files
├── assets/
│   ├── images/         # Local static assets
│   └── .env            # Environment configuration (Not tracked in git)
├── lib/
│   ├── components/     # Highly reusable, isolated widget structures (e.g., NavBars, AppBars)
│   ├── models/         # Core application DTOs (Data Transfer Objects) mapping JSON
│   ├── pages/          # Main logical entry points for application routing
│   ├── services/       # Abstractions for external integration (HTTP, Geolocation)
│   └── main.dart       # Application entry point and global state configuration
└── pubspec.yaml        # Flutter dependency manager
```

### 🧠 Domain Logic Breakdown

- **`lib/models/`**: Contains Standard Data Transfer Objects (DTOs). Complex JSON mappings cleanly convert raw, unstructured HTTP responses into strongly-typed configurations ready for UI injection. Includes entities like `Weather`, `HourlyForecast`, and `DailyForecast`.
- **`lib/services/`**: Securely implements external API endpoint access and firmly couples geographical logic to OS-level geolocation services, keeping data fetching completely abstracted from UI lifecycles.
- **`lib/components/`**: Houses self-contained layout structures to avoid boilerplate duplication. Handles global UI components like the base AppBar and the interactive dynamic Bottom Navigation Bar.
- **`lib/pages/`**: The core routing views that connect the global state with specific modular features.

---

## 🛣️ Navigation & Routing

Atmospheric implements a static bottom-bar indexed stack routing architecture, ensuring the user's progress and the application's state are preserved smoothly across tabs without unnecessary re-rendering.

1. **`Home / Dashboard View`** (`lib/pages/home.dart`): The central core computing and rendering the application's live telemetry endpoints. It showcases beautiful 24-hour horizontal scrolling lists and a processed 5-day absolute high/low chart.
2. **`Location View`** (`lib/pages/location.dart`): Dedicated space for localized metrics like UV Index, Sunset tracking, Air Quality (AQI), and 7-day extended forecasts in a glassmorphic aesthetic layout.
3. **`Search View`** (`lib/pages/search.dart`): A smooth UI meant to intercept inputs for global location polling, displaying recent searches, and popular global suggestions over a greyscaled global map background.
4. **`Settings View`** (`lib/pages/settings.dart`): Dedicated to user preferences. Features aesthetic options for theme management (Dark Mode), Unit switching (Metric/Imperial), Notification toggles, and "About" information.

---

## 📡 API Endpoints & Logic Sync

Atmospheric uses the **OpenWeather API** (Free Tier Mode), efficiently structured to minimize network requests while maximizing displayed information.

**Base URL**: `https://api.openweathermap.org/data/2.5`

1. **Current Weather Snapshot**
   - **Endpoint**: `GET /weather`
   - **Purpose**: Collects instantaneous weather data driven by the device's geolocation parameters (`lat` and `lon`). Populates core static metrics visually on the dashboard: Main Temperature, Visibility, Relative Humidity, and Barometric Pressure.

2. **Predictive Analytics Matrix (5-Day Forecast)**
   - **Endpoint**: `GET /forecast`
   - **Purpose**: A comprehensive forecasting tool that pulls 40 discrete timestamps (spaced 3 hours apart).
   - **Internal Aggregation Engine**:
     - *Hourly Scale:* Maps directly to extract adjacent upcoming windows, forming the 24-hour horizontal predictive slider.
     - *Daily Computation:* A custom aggregation model loops through all independent 3-hour data points, sequentially grouping them by their literal calendar day. It then isolates absolute minimums (`minTemp`) and maximums (`maxTemp`) for that specific day, projecting those limits into the 5-Day grouped UI queue (`weather.daily`).

---

## 📦 Core Dependencies

This project takes advantage of highly optimized Flutter packages to handle hard integrations efficiently:

- `http`: Handles the REST layer integration, providing fast parsing tools for API ingestion.
- `geolocator`: Seamless dynamic real-time positional tracking connecting directly to native device GPS sensors (iOS/Android).
- `geocoding`: Re-routes generic global coordinates back into exact geographic region limitations, resolving state boundaries and city text.
- `flutter_dotenv`: Safe environment token injector to secure API payloads, preventing accidental git exposure.
- `logger`: Professional console output tracking to manage request lifecycles and HTTP error boundaries.

---

## 🚀 Installation & Setup

To run Atmospheric locally, follow these steps:

### 1. Prerequisites
Ensure you have the following installed on your machine:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Version 3.11.0 or higher)
- IDE (VS Code, Android Studio, IntelliJ)
- Active Android/iOS Emulator or Physical Device

### 2. Clone the Repository
```bash
git clone https://github.com/your-username/atmospheric.git
cd atmospheric
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Setup Environment Variables
Atmospheric requires an OpenWeather API Key to function. 
1. Get a free API key from [OpenWeatherMap](https://openweathermap.org/api).
2. Create a file named `.env` in the root directory.
3. Open `.env` and add your API key like so:
```env
API_KEY=your_actual_api_key_here
```
*(Note: The `.env` file is excluded in `.gitignore` by default to prevent leakage).*

### 5. Run the Application
Start your emulator or plug in your device, then execute:
```bash
flutter run
```

---

## 🤝 Contributing

We welcome community contributions! If you'd like to help improve Atmospheric, follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---
<div align="center">
  <p><b>ATMOSPHERIC WEATHER ENGINE</b><br><i>"Refining Your Sky Since 2024"</i></p>
</div>
