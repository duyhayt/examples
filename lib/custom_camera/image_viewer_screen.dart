import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewerScreen extends StatefulWidget {
  final List<String> images;

  const ImageViewerScreen({super.key, required this.images});

  @override
  _ImageViewerScreenState createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  int currentIndex = 0; // Ảnh hiện tại

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Xem ảnh'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 📸 Hiển thị ảnh hiện tại
          Center(
            child: Image.file(
              File(widget.images[currentIndex]),
              fit: BoxFit.contain,
              width: double.infinity,
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
          if (currentIndex < widget.images.length - 1)
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
        ],
      ),
    );
  }
}
