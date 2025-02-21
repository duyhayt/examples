import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testkey/custom_camera/overlay_widget.dart';

class ImageViewerScreen extends StatefulWidget {
  const ImageViewerScreen({super.key});

  @override
  _ImageViewerScreenState createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  List<File> imageFiles = []; // Danh sách ảnh đã chụp
  int currentIndex = 0; // Vị trí ảnh hiện tại

  @override
  void initState() {
    super.initState();
    _loadCapturedPhotos(); // Gọi hàm lấy danh sách ảnh khi vào màn hình
  }

  /// 🖼 **Lấy danh sách ảnh từ thư mục `camerawesome/`**
  Future<void> _loadCapturedPhotos() async {
    final directory = await getTemporaryDirectory(); // Lấy thư mục Cache
    final String path = '${directory.path}/camerawesome';

    final dir = Directory(path);
    if (await dir.exists()) {
      List<File> images = dir
          .listSync() // Lấy danh sách file
          .whereType<File>() // Lọc ra chỉ lấy file
          .where((file) => file.path.endsWith('.jpg') || file.path.endsWith('.png')) // Lọc file ảnh
          .toList();

      setState(() {
        imageFiles = images.reversed.toList(); // Ảnh mới nhất hiển thị trước
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageFiles.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: const Text('Xem ảnh'),
        ),
        body: const Center(
          child: Text('Chưa có ảnh nào!', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Xem ảnh'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 📸 Hiển thị ảnh hiện tại
          Center(
            child: Image.file(
              imageFiles[currentIndex],
              fit: BoxFit.cover,
            ),
          ),

          // 🔙 Nút quay lại ảnh trước
          if (currentIndex > 0)
            Positioned(
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                onPressed: () {
                  setState(() {
                    currentIndex--;
                  });
                },
              ),
            ),

          // 🔜 Nút sang ảnh tiếp theo
          if (currentIndex < imageFiles.length - 1)
            Positioned(
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30),
                onPressed: () {
                  setState(() {
                    currentIndex++;
                  });
                },
              ),
            ),
            const DraggableOverlayWidget(),
        ],
      ),
    );
  }
}
