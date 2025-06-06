# Path Animation

[![pub package](https://img.shields.io/pub/v/path_animation.svg)](https://pub.dev/packages/path_animation)

A powerful Flutter animation package that allows widgets to move along custom paths. With Path Animation, you can easily create animations that follow any path (straight lines, curves, circles, ovals, etc.), adding engaging and interactive experiences to your applications.

[中文文档](README_CN.md)

![Screenshot](https://github.com/haishuangsu/path_animation/blob/master/screenshot/solar.gif?raw=true) ![Screenshot](https://github.com/haishuangsu/path_animation/blob/master/screenshot/vortex.gif?raw=true)

## Features

- 🛤️ Support for any custom path animation
- 🔄 Support for loop and reverse playback
- ⏱️ Customizable animation duration and curves
- 🎨 Optional path display with styling options
- 🚀 High-performance, smooth animations
- 📱 Support for all Flutter platforms

## Getting started

This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):

```yaml
dependencies:
  path_animation: ^1.1.1
```

## Usage

```dart
import 'package:path_animation/widget/path_animation.dart';

    PathAnimation(
        path: Path()..addOval(const Rect.fromLTWH(0, 0, 100, 100)), // Set the path.
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        reverse: false,
        curve: Curves.decelerate,
        startAnimatedPercent: 0.25,
        drawPath: true,
        pathColor: Colors.red,
        pathWidth: 1,
        child: const Icon(      // The Widget you want to animated to cross the path.
            Icons.flutter_dash,
            size: 30,
        ),
    ),
```