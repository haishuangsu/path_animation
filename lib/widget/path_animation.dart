import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path_animation/ext/measure.dart';

import 'package:path_animation/widget/path_painter.dart';

// ignore: must_be_immutable
class PathAnimation extends StatefulWidget {
  PathAnimation({
    super.key,
    required this.child,
    required this.path,
    this.duration = const Duration(milliseconds: 1000),
    this.repeat = false,
    this.reverse = false,
    this.curve = Curves.linear,
    this.startAnimatedPercent = 0.0,
    this.drawPath = false,
    this.pathColor = Colors.blue,
    this.pathWidth = 1.0,
  }) : assert(
          0.0 <= startAnimatedPercent && startAnimatedPercent <= 1.0,
          'startAnimatedPercent must be between 0.0 and 1.0',
        );

  final Widget child;
  final Path path;
  Duration duration;
  bool drawPath;
  bool repeat;
  bool reverse;
  Curve curve;
  Color pathColor;
  double pathWidth;
  double startAnimatedPercent;

  @override
  State<StatefulWidget> createState() => _PathAnimationState();
}

class _PathAnimationState extends State<PathAnimation>
    with SingleTickerProviderStateMixin {
  late Ticker ticker;
  late double currentAnimatedPercent;
  late ui.PathMetric firstMetric;
  late Size childSize;
  Offset currentOffset = Offset.zero;
  late double initElapsed;

  @override
  void initState() {
    currentAnimatedPercent = widget.startAnimatedPercent;
    childSize = widget.child.measure();
    firstMetric = widget.path.computeMetrics().first;

    if (widget.startAnimatedPercent > 0.0) {
      initElapsed = widget.duration.inMicroseconds.toDouble() *
          widget.startAnimatedPercent;

      ui.Tangent? tangent = firstMetric.getTangentForOffset(
          firstMetric.length * widget.curve.transform(currentAnimatedPercent));
      currentOffset = tangent!.position
          .translate(-childSize.width / 2, -childSize.height / 2);
    }

    ticker = createTicker(_onTick);
    if (mounted) {
      ticker.start();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PathAnimation oldWidget) {
    if (oldWidget.repeat != widget.repeat ||
        oldWidget.reverse != widget.reverse ||
        oldWidget.duration != widget.duration ||
        oldWidget.curve != widget.curve ||
        oldWidget.startAnimatedPercent != widget.startAnimatedPercent) {
      ticker.stop();
      currentAnimatedPercent = 0.0;
      ticker.start();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    if (widget.startAnimatedPercent > 0.0) {
      currentAnimatedPercent =
          (initElapsed + elapsed.inMicroseconds.toDouble()) /
              widget.duration.inMicroseconds.toDouble();
    } else {
      currentAnimatedPercent = elapsed.inMicroseconds.toDouble() /
          widget.duration.inMicroseconds.toDouble();
    }

    if (widget.repeat) currentAnimatedPercent %= 1.0;

    currentAnimatedPercent = widget.reverse
        ? ui.lerpDouble(1.0, 0.0, currentAnimatedPercent)!
        : ui.lerpDouble(0.0, 1.0, currentAnimatedPercent)!;
    currentAnimatedPercent = clampDouble(currentAnimatedPercent, 0.0, 1.0);
    _update();
  }

  void _update() {
    assert(currentAnimatedPercent <= 1.0);

    ui.Tangent? tangent = firstMetric.getTangentForOffset(
        firstMetric.length * widget.curve.transform(currentAnimatedPercent));
    setState(() {
      currentOffset = tangent!.position
          .translate(-childSize.width / 2, -childSize.height / 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Transform.translate(
      offset: currentOffset,
      child: widget.child,
    );

    if (widget.drawPath) {
      child = CustomPaint(
        painter: PathPainter(
          path: widget.path,
          pathColor: widget.pathColor,
          pathWidth: widget.pathWidth,
        ),
        child: child,
      );
    }
    return RepaintBoundary(child: child);
  }
}
