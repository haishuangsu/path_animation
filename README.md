<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A Flutter package for easy to animated the widget cross the path.

![Screenshot](https://github.com/haishuangsu/path_animation/blob/master/screenshot/screenshot.gif)


## Getting started

This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):

```yaml
dependencies:
  path_animation: ^0.1.1
```


## Usage

```dart
import 'package:path_animation/widget/path_animation.dart';

    PathAnimation(
        path: Path()..addOval(const Rect.fromLTWH(100, 100, 100, 100)), // Set the path.
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        reverse: false,
        curve: Curves.decelerate,
        drawPath: true,
        pathColor: Colors.red,
        pathWidth: 1,
        child: const Icon(      // The Widget you want to animated to cross the path.
            Icons.flutter_dash,
            size: 30,
        ),
    ),
```