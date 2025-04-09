# 路径动画 (Path Animation)

[![pub package](https://img.shields.io/pub/v/path_animation.svg)](https://pub.dev/packages/path_animation)

一个强大的 Flutter 动画包，专门用于沿着自定义路径移动 Widget。通过 Path Animation，您可以轻松创建沿任意路径（如直线、曲线、圆形、椭圆形等）移动的动画效果，为您的应用增添生动有趣的交互体验。

[English](README.md)

![Screenshot](https://github.com/haishuangsu/path_animation/blob/master/screenshot/solar.gif?raw=true) ![Screenshot](https://github.com/haishuangsu/path_animation/blob/master/screenshot/vortex.gif?raw=true)

## 特性

- 🛤️ 支持任意自定义路径动画
- 🔄 支持循环播放和反向播放
- ⏱️ 自定义动画持续时间和曲线
- 🎨 可选择是否显示路径及其样式
- 🚀 高性能，流畅的动画体验
- 📱 支持所有 Flutter 平台

## 开始使用

将以下代码添加到您的 pubspec.yaml 文件中（并运行 flutter pub get）：

```yaml
dependencies:
  path_animation: ^1.1.1
```

## 使用
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