import 'package:flutter/material.dart';

class DashedSliderTrackShape extends SliderTrackShape {
  final Color inactiveTrackColor;
  final Color activeTrackColor;
  final int dashCount;

  DashedSliderTrackShape({
    required this.inactiveTrackColor,
    required this.activeTrackColor,
    this.dashCount = 10,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 0;
    final double trackWidth = parentBox.size.width;
    final double thumbRadius =
        sliderTheme.thumbShape!.getPreferredSize(isEnabled, isDiscrete).width /
            2;
    final double trackLeft = offset.dx + thumbRadius;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackRight = trackLeft + trackWidth - 2 * thumbRadius;
    final double trackBottom = trackTop + trackHeight;
    return Rect.fromLTRB(trackLeft, trackTop, trackRight, trackBottom);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double? additionalParentContentHeight,
    Offset? secondaryOffset,
  }) {
    final Canvas canvas = context.canvas;
    final Size size = parentBox.size;
    final double trackHeight = sliderTheme.trackHeight ?? 0;
    final double trackWidth = size.width;
    final double thumbRadius =
        sliderTheme.thumbShape!.getPreferredSize(isEnabled, isDiscrete).width /
            2;
    final double trackLeft = offset.dx + thumbRadius;
    final double trackTop = offset.dy + (size.height - trackHeight) / 2;
    final double trackRight = trackLeft + trackWidth - 2 * thumbRadius;

    final Paint inactivePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackHeight;

    final Paint activePaintDash = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackHeight;

    final Paint activePaintLine = Paint()
      ..color = activeTrackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackHeight;

    canvas.drawLine(
      Offset(trackLeft, trackTop),
      Offset(trackRight, trackTop),
      inactivePaint,
    );

    final double dashWidth = trackWidth / (dashCount * 2);
    final double dashSpace = dashWidth;

    for (int i = 0; i < dashCount; i++) {
      final double dashX = trackLeft + i * (dashWidth + dashSpace);
      canvas.drawLine(
        Offset(dashX, trackTop),
        Offset(dashX + dashWidth * 1.25, trackTop),
        activePaintDash,
      );

      final double solidLineEndX = thumbCenter.dx;
      canvas.drawLine(
        Offset(trackLeft, trackTop),
        Offset(solidLineEndX, trackTop),
        activePaintLine,
      );
    }
  }
}
