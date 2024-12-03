import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:testkey/pdf/models/coordinate_model.dart';
import 'package:testkey/pdf/widgets/corner_handler_widget.dart';
import 'package:testkey/pdf/widgets/decorated_box_widget.dart';

class TransformableBoxWidget extends StatelessWidget {
  final CoordinateModel box;
  final double zoomLevel;
  final Offset scrollOffset;
  final Function(CoordinateModel updatedBox) onBoxChanged;

  const TransformableBoxWidget({
    super.key,
    required this.box,
    required this.zoomLevel,
    required this.scrollOffset,
    required this.onBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TransformableBox(
      rect: Rect.fromLTWH(
        (box.x - scrollOffset.dx) * zoomLevel,
        (box.y - scrollOffset.dy) * zoomLevel,
        box.width * zoomLevel,
        box.height * zoomLevel,
      ),
      resizable: true,
      allowFlippingWhileResizing: false,
      flip: Flip.none,
      onChanged: (result, event) {
        final updatedBox = box.copyWith(
          x: (result.rect.left / zoomLevel) + scrollOffset.dx,
          y: (result.rect.top / zoomLevel) + scrollOffset.dy,
          width: result.rect.width / zoomLevel,
          height: result.rect.height / zoomLevel,
          pageNumber: box.pageNumber,
        );
        onBoxChanged(updatedBox);
      },
      contentBuilder: (context, rect, flip) => const DecoratedBoxWidget(),
      visibleHandles: const {...HandlePosition.corners},
      cornerHandleBuilder: (context, handle) =>
          CornerHandlerWidget(handle: handle),
    );
  }
}
