# What Could be NEXT? - Flutter

A beautiful glassmorphism-themed multi-step form screen built with Flutter and Riverpod.

## Features

- **Step 1**: Color selection with 4 options (Red, Green, Yellow, Unknown)
- **Step 2**: Animal selection (A-D) with colored backgrounds based on Step 1
- **Step 3**: Variant selection for each selected animal with skip option
- **Glassmorphism Design**: Beautiful frosted glass effect throughout
- **State Management**: Clean Riverpod architecture
- **Navigation**: Automatic progression and back button support

## Installation

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9

dev_dependencies:
  flutter_lints: ^3.0.0
```

## Project Structure

```
lib/
  ├── what_happen_controller.dart  # Riverpod state management
  ├── what_happen_screen.dart      # UI implementation
  └── main.dart                     # App entry point
```

## Usage

### 1. Import the required files

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'what_happen_screen.dart';
```

### 2. Wrap your app with ProviderScope

```dart
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What Happen Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const WhatHappenScreen(),
    );
  }
}
```

## How It Works

### State Management

The `WhatHappenController` manages:
- Current step (1-3)
- Selected color from Step 1
- Selected animals from Step 2
- Selected variants for each animal in Step 3

### User Flow

1. **Step 1**: User selects a color → Automatically moves to Step 2
2. **Step 2**: User selects an animal or skips
   - If animal selected → Moves to Step 3
   - If skipped → Resets the flow
3. **Step 3**: User selects variants for each animal
   - Displays 2-4 options based on Step 2 selections
   - Each option has A, B, C variant choices
   - Can skip to complete the flow

### Accessing State in Other Widgets

```dart
// In any ConsumerWidget or ConsumerStatefulWidget
final state = ref.watch(whatHappenControllerProvider);
final controller = ref.read(whatHappenControllerProvider.notifier);

// Access state properties
print(state.currentStep);
print(state.selectedColor);
print(state.selectedAnimals);
print(state.selectedVariants);

// Call controller methods
controller.selectColor(AnimalColor.red);
controller.selectAnimal(AnimalType.panda);
controller.selectVariant(AnimalType.panda, 1);
```

## Customization

### Colors

Modify the gradient background in `WhatHappenScreen`:

```dart
decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.purple.shade900,  // Change these
      Colors.blue.shade900,
      Colors.pink.shade900,
    ],
  ),
),
```

### Glass Effect

Adjust the blur intensity in `GlassContainer`:

```dart
BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1), // Adjust opacity
      ...
    ),
  ),
)
```

### Add More Options

To add more animals or colors:

1. Update the enums in `what_happen_controller.dart`
2. Add corresponding boxes in the UI
3. Handle the new cases in switch statements

## Models

```dart
enum AnimalType { panda, tiger, elephant, crocodile }
enum AnimalColor { red, green, yellow }

class Animal {
  final AnimalType type;
  final int? variant;
  final String? description;
}

class AnimalItem {
  final Animal? animal;
  final AnimalColor? color;
}
```

## Features Breakdown

### Glassmorphism Components

- `GlassContainer`: Reusable frosted glass container
- `GlassButton`: Glassmorphism-styled button
- `GlassIconButton`: Icon button with glass effect
- `ColorBox`: Color selection box with glass effect
- `AnimalBox`: Animal selection with colored background
- `VariantBox`: Variant selection box
- `VariantSelector`: Complete variant selection row

### Navigation

- Back button appears from Step 2 onwards
- Automatic progression on selection
- Manual skip options in Steps 2 and 3

## Tips

- The screen automatically handles state transitions
- Use the back button to go to previous steps
- Skip buttons allow users to bypass optional steps
- The controller logs completion data to console
- Customize the `completeFlow()` method to handle data persistence

## License

This is a sample implementation. Feel free to use and modify as needed.
