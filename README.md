# Chess Player Analyzer Qt

Qt/QML implementation of the Chess Player Analyzer application, translated from the React version.

## Overview

This is a Qt/QML port of the Chess Player Analyzer React application's main page. The application provides a dark-themed interface for analyzing chess player performance with features including:

- **Header**: Chess Analyzer branding with green accent
- **Main Analysis Section**: Input form for chess.com username analysis
- **Features Grid**: Four feature cards showcasing analysis capabilities
- **Analyzed Players Section**: Display area for analyzed players with loading animations

## Features

- **Opening Entropy**: Analyze opening diversity vs ELO consistency
- **Move Timing**: Detect suspicious timing patterns  
- **Win/Loss Stats**: Comprehensive game outcome analysis
- **Comeback Analysis**: Identify dramatic game turnarounds

## Requirements

- Qt 5.15+ with QML support
- QtQuick 2.15
- QtQuick.Controls 2.15
- QtQuick.Layouts 1.15

## Installation

### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install qml-module-qtquick2 qml-module-qtquick-controls2 qml-module-qtquick-layouts
```

### Other Systems
Install Qt with QML support through your package manager or from the official Qt website.

## Running the Application

### Method 1: Using the run script (recommended)
```bash
chmod +x run.sh
./run.sh
```

### Method 2: Direct execution
```bash
qml main.qml
```

### Method 3: Using qmlscene
```bash
qmlscene main.qml
```

## Project Structure

```
├── main.qml           # Main application window and layout
├── FeatureCard.qml    # Reusable component for feature cards
├── qmldir             # QML module definition
├── run.sh             # Script to run the QML application
├── CMakeLists.txt     # CMake build configuration
├── main.cpp           # C++ main entry point for compiled version
└── README.md          # This file
```

## Visual Design

The QML version recreates the exact visual design of the React application:

- **Background**: Black (#000000)
- **Cards**: Dark gray (#1f2937) with gray borders (#374151)
- **Text**: White primary text with gray secondary text (#9ca3af)
- **Accent**: Green (#16a34a) for buttons and branding
- **Layout**: Responsive design with proper spacing and rounded corners

## Components

### main.qml
The main application window containing:
- Application header with Chess Analyzer branding
- Centered main content area with analysis input form
- Grid layout of four feature cards
- Analyzed players section with loading skeleton animation

### FeatureCard.qml
Reusable component for feature cards with properties:
- `iconText`: Emoji or text icon
- `iconColor`: Color of the icon text
- `iconBgColor`: Background color of the icon container
- `title`: Card title text
- `description`: Card description text

## Development

The application is built using Qt/QML and follows modern QML best practices:
- Modular component architecture
- Property-based customization
- Responsive layout design
- Consistent theming and styling

## Building with CMake

For a compiled version using CMake:

```bash
mkdir build
cd build
cmake ..
make
./ChessPlayerAnalyzerQt
```

## Translation from React

This QML implementation is a faithful translation of the React application's main page, maintaining:
- Identical visual design and layout
- Same color scheme and typography
- Equivalent component structure and hierarchy
- Matching spacing, padding, and visual effects

## License

This project follows the same license as the original React application.
