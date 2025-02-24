import 'package:flutter/material.dart';

class DraggableOverlayWidget extends StatefulWidget {
  const DraggableOverlayWidget({super.key});

  @override
  _DraggableOverlayWidgetState createState() => _DraggableOverlayWidgetState();
}

class _DraggableOverlayWidgetState extends State<DraggableOverlayWidget> {
  Offset position = const Offset(100, 200); // Vị trí ban đầu
  List<String> itemOverlay = ["High", "Low"];
  String severity = "Low"; 

  @override
  Widget build(BuildContext context) {
    Color overlayColor = severity == "High"
        ? Colors.red.withOpacity(0.6)
        : Colors.orange.withOpacity(0.6);
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
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: overlayColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: severity,
                        dropdownColor: Colors.white,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        style: const TextStyle(color: Colors.black),
                        underline: Container(),
                        items: itemOverlay
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            severity = value!;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.black, size: 20),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Minor corrosion on fixings of partition board (used to seal window opening, partition board well intact)",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
