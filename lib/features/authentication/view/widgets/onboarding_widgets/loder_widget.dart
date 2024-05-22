

import 'package:flutter/material.dart';
import 'package:rent_hub/core/theme/app_theme.dart';

class CircularProgressBar extends StatelessWidget {
  final double progress;
  // value between 0 and 1
  const CircularProgressBar({super.key, required this.progress});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.spaces.space_700,
      height: context.spaces.space_700,
      // height: 58,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(context.spaces.space_700, context.spaces.space_700),
            painter: _CircularProgressBarPainter(progress,context),
          ),
          Container(
            width: 45, // Width of the inner circle
            height: 45, // Height of the inner circle
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context
                  .colors.primary, // Background color of the inner circle
            ),
            child: Center(
              child: Icon(
                Icons.chevron_right, // Arrow icon
                color: Colors.white,
                size: context.spaces.space_300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularProgressBarPainter extends CustomPainter {
  final double progress;
  final BuildContext context;
  _CircularProgressBarPainter(this.progress, this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    final progressPaint = Paint()
      ..color = context.colors.primary
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final center = Offset(size.width / context.spaces.space_25,
        size.height / context.spaces.space_25);
    final radius = size.width / context.spaces.space_25;
    canvas.drawCircle(center, radius, paint);
    final startAngle = -90.0 * (3.14 / 180);
    final sweepAngle = 360.0 * progress * (3.14 / 180);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
