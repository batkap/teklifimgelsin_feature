import 'package:flutter/material.dart';

class SliderComponentThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double borderThickness;
  final Color borderColor;

  const SliderComponentThumbShape({
    required this.thumbRadius,
    required this.borderThickness,
    required this.borderColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius + borderThickness);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint outerCirclePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..strokeWidth = borderThickness
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 0.5);

    final Paint outerBorderPaint = Paint()
      ..color = const Color.fromRGBO(28, 28, 28, 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThickness;

    final Paint innerCirclePaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      center,
      thumbRadius + borderThickness + 1.45,
      outerBorderPaint,
    );

    canvas.drawCircle(
      center,
      thumbRadius + borderThickness + 2,
      outerCirclePaint,
    );

    canvas.drawCircle(
      center,
      thumbRadius,
      innerCirclePaint,
    );
  }
}
