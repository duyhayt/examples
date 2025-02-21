import 'package:flutter/material.dart';

class DraggablePinWidget extends StatefulWidget {
  final String label;
  final VoidCallback? onClose;

  const DraggablePinWidget({super.key, required this.label, this.onClose});

  @override
  _DraggablePinWidgetState createState() => _DraggablePinWidgetState();
}

class _DraggablePinWidgetState extends State<DraggablePinWidget> {
  Offset position = const Offset(100, 250);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position = Offset(
              position.dx + details.delta.dx,
              position.dy + details.delta.dy,
            );
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 📌 **Pin Widget**
            CustomPaint(
              painter: PinShapePainter(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🎯 Icon định vị
                    const Icon(Icons.gps_fixed, size: 16, color: Colors.black),
                    const SizedBox(width: 4),

                    // 🔢 Số thay đổi động
                    Text(
                      widget.label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    // ❌ Nút xóa
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: widget.onClose,
                        child: const Icon(Icons.close, size: 14, color: Colors.black),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🎨 **Custom Painter để vẽ viền & bo góc**
class PinShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.orange.shade200 // 🟠 Nền cam nhạt
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.orange.shade800 // 🟠 Viền cam đậm
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Path path = Path()
      ..moveTo(size.height * 0.4, 0) // Bo góc trái
      ..lineTo(size.width - size.height * 0.5, 0)
      ..arcToPoint(Offset(size.width, size.height * 0.5),
          radius: Radius.circular(size.height * 0.5))
      ..lineTo(size.width, size.height - size.height * 0.5)
      ..arcToPoint(Offset(size.width - size.height * 0.5, size.height),
          radius: Radius.circular(size.height * 0.5))
      ..lineTo(size.height * 0.4, size.height)
      ..quadraticBezierTo(0, size.height / 2, size.height * 0.4, 0)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
