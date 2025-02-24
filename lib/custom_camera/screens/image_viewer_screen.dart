import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testkey/custom_camera/custom/custom_pin.dart';

import '../widgets/overlay_widget.dart';

class ImageViewerScreen extends StatefulWidget {
  const ImageViewerScreen({super.key});

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  List<File> imageFiles = [];
  int currentIndex = 0;
  Color selectedColor = Colors.red; // Màu vẽ mặc định

  @override
  void initState() {
    super.initState();
    _loadCapturedPhotos();
  }

  Future<void> _loadCapturedPhotos() async {
    final directory = await getTemporaryDirectory();
    final String path = '${directory.path}/camerawesome';

    final dir = Directory(path);
    if (await dir.exists()) {
      List<File> images = dir
          .listSync()
          .whereType<File>()
          .where((file) =>
              file.path.endsWith('.jpg') || file.path.endsWith('.png'))
          .toList();

      setState(() {
        imageFiles = images.reversed.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Done',
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          const SizedBox(width: 10.0)
        ],
      ),
      body: InteractiveViewer(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Image.file(
                imageFiles.isNotEmpty ? imageFiles[currentIndex] : File(''),
                fit: BoxFit.cover,
              ),
            ),
            const DraggableOverlayWidget(),
            const DraggablePinWidget(
              label: '5-01',
            ),
            const DraggablePinWidget(
              label: '5-07',
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 120,
        color: Colors.blue[900],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildColorButton(Colors.red),
                  _buildColorButton(Colors.yellow),
                  _buildColorButton(Colors.green),
                  _buildColorButton(Colors.cyan),
                  _buildColorButton(Colors.blue),
                  _buildColorButton(Colors.purple),
                  _buildColorButton(Colors.pink),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildToolButton(Icons.brush, "Bút vẽ", () {}),
                _buildToolButton(Icons.arrow_forward, "Mũi tên", () {}),
                _buildToolButton(Icons.crop, "Cắt ảnh", () {}),
                _buildToolButton(Icons.text_fields, "Thêm chữ", () {}),
                _buildToolButton(Icons.delete, "Xóa", () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🎨 **Nút chọn màu vẽ**
  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selectedColor == color
              ? Border.all(color: Colors.white, width: 3)
              : null,
        ),
      ),
    );
  }

  /// 🛠 **Nút công cụ chỉnh sửa**
  Widget _buildToolButton(
      IconData icon, String tooltip, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: 28),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
