import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path_animation/ext/measure.dart';

import 'package:path_animation/widget/path_painter.dart';

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
  })  : width = path.getBounds().width,
        height = path.getBounds().height,
        assert(
          0.0 <= startAnimatedPercent && startAnimatedPercent <= 1.0,
          'startAnimatedPercent must be between 0.0 and 1.0',
        );

  final Widget child;
  final double width;
  final double height;
  final Path path;
  final Duration duration;
  final bool drawPath;
  final bool repeat;
  final bool reverse;
  final Curve curve;
  final Color pathColor;
  final double pathWidth;
  final double startAnimatedPercent;

  @override
  State<StatefulWidget> createState() => _PathAnimationState();
}

class _PathAnimationState extends State<PathAnimation> with SingleTickerProviderStateMixin {
  late Ticker ticker;
  late double currentAnimatedPercent;
  late ui.PathMetric firstMetric;
  late Size childSize;
  Offset currentOffset = Offset.zero;
  late double initElapsed;
  late double width;
  late double height;
  double topLeftX = 0.0;
  double topLeftY = 0.0;

  @override
  void initState() {
    currentAnimatedPercent = widget.startAnimatedPercent;
    _prepareChild();

    if (widget.startAnimatedPercent > 0.0) {
      initElapsed = widget.duration.inMicroseconds.toDouble() * widget.startAnimatedPercent;
      _updateOffset();
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
        oldWidget.startAnimatedPercent != widget.startAnimatedPercent ||
        oldWidget.path != widget.path) {
      ticker.stop();
      currentAnimatedPercent = 0.0;
      _prepareChild();
      ticker.start();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _prepareChild() {
    childSize = widget.child.measure();
    _computeSize();
    firstMetric = widget.path.computeMetrics().first;
  }

  void _computeSize() {
    topLeftX = widget.path.getBounds().topLeft.dx;
    topLeftY = widget.path.getBounds().topLeft.dy;
    if (widget.height == 0.0) {
      width = widget.width;
      height = childSize.height;
    } else if (widget.width == 0.0) {
      width = childSize.width;
      height = widget.height;
    } else {
      width = widget.width;
      height = widget.height;
    }
    width += childSize.width / 2;
    height += childSize.height / 2;
    width += topLeftX;
    height += topLeftY;
  }

  void _onTick(Duration elapsed) {
    if (widget.startAnimatedPercent > 0.0) {
      currentAnimatedPercent =
          (initElapsed + elapsed.inMicroseconds.toDouble()) / widget.duration.inMicroseconds.toDouble();
    } else {
      currentAnimatedPercent = elapsed.inMicroseconds.toDouble() / widget.duration.inMicroseconds.toDouble();
    }

    if (widget.repeat) currentAnimatedPercent %= 1.0;

    currentAnimatedPercent = widget.reverse
        ? ui.lerpDouble(1.0, 0.0, currentAnimatedPercent)!
        : ui.lerpDouble(0.0, 1.0, currentAnimatedPercent)!;
    currentAnimatedPercent = clampDouble(currentAnimatedPercent, 0.0, 1.0);

    if (!widget.repeat &&
        elapsed.inMicroseconds / Duration.microsecondsPerSecond >
            widget.duration.inMicroseconds / Duration.microsecondsPerSecond) {
      ticker.stop();
    }
    _update();
  }

  void _update() {
    assert(currentAnimatedPercent <= 1.0);
    _updateOffset();
    setState(() {});
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void _updateOffset() {
    final tangent =
        firstMetric.getTangentForOffset(firstMetric.length * widget.curve.transform(currentAnimatedPercent));

    if (tangent == null) {
      return;
    }

    currentOffset = tangent.position.translate(-(widget.width / 2), -(widget.height / 2));
    if (topLeftX != 0.0 || topLeftY != 0.0) {
      currentOffset = currentOffset.translate(-topLeftX / 2, -topLeftY / 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (widget.drawPath)
          Padding(
            padding: EdgeInsets.only(left: topLeftX, top: topLeftY),
            child: SizedBox(
              width: width,
              height: height,
              child: CustomPaint(
                painter: PathPainter(
                  path: widget.path.shift(Offset(childSize.width / 4, childSize.height / 4)),
                  pathColor: widget.pathColor,
                  pathWidth: widget.pathWidth,
                ),
              ),
            ),
          ),
        RepaintBoundary(
          child: Transform.translate(
            offset: currentOffset,
            child: widget.child,
          ),
        )
      ],
    );
  }
}
