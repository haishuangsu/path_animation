import 'dart:ui';

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
    this.curve = Curves.linear,
    this.drawPath = false,
    this.pathColor = Colors.blue,
    this.pathWidth = 1.0,
  });

  final Widget child;
  final Path path;
  Duration duration;
  bool drawPath;
  bool repeat;
  Curve curve;
  Color pathColor;
  double pathWidth;

  @override
  State<StatefulWidget> createState() => _PathAnimationState();
}

class _PathAnimationState extends State<PathAnimation>
    with SingleTickerProviderStateMixin {
  Offset currentOffset = Offset.zero;

  late Ticker ticker;
  double animatedPercent = 0.0;

  late PathMetric firstMetric;
  late Size childSize;

  @override
  void initState() {
    childSize = widget.child.measure();
    firstMetric = widget.path.computeMetrics().first;

    ticker = createTicker(_onTick);
    if (mounted) {
      ticker.start();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PathAnimation oldWidget) {
    if (oldWidget.repeat != widget.repeat ||
        oldWidget.duration != widget.duration ||
        oldWidget.curve != widget.curve) {
      ticker.stop();
      animatedPercent = 0.0;
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
    animatedPercent = (elapsed.inMicroseconds.toDouble() /
        widget.duration.inMicroseconds.toDouble());
    if (widget.repeat) animatedPercent %= 1.0;
    animatedPercent = clampDouble(animatedPercent, 0.0, 1.0);
    _update();
  }

  void _update() {
    assert(animatedPercent <= 1.0);
    Tangent? tangent = firstMetric.getTangentForOffset(
        firstMetric.length * widget.curve.transform(animatedPercent));
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
