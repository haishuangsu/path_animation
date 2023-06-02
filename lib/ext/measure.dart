import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_animation/boxs/measureview.dart';

extension WidgetMeasure on Widget {
  static PipelineOwner pipelineOwner = PipelineOwner();
  static BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

  Size measure() {
    final MeasurementView rootView = pipelineOwner.rootNode = MeasurementView();
    final RenderObjectToWidgetElement<RenderBox> element =
        RenderObjectToWidgetAdapter<RenderBox>(
      container: rootView,
      debugShortDescription: '[root]',
      child: Directionality(textDirection: TextDirection.ltr, child: this),
    ).attachToRenderTree(buildOwner);
    try {
      rootView.scheduleInitialLayout();
      pipelineOwner.flushLayout();
      return rootView.size;
    } finally {
      element
          .update(RenderObjectToWidgetAdapter<RenderBox>(container: rootView));
      buildOwner.finalizeTree();
    }
  }
}
