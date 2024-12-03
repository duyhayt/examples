import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class CornerHandlerWidget extends StatelessWidget {
  final HandlePosition handle;
  const CornerHandlerWidget({super.key, required this.handle});

  @override
  Widget build(BuildContext context) {
    return DefaultCornerHandle(
          size: 15,
          handle: handle,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.blueAccent,
              width: 2,
            ),
          ),
        );
  }
}