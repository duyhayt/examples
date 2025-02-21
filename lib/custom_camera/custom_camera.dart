import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:testkey/custom_camera/image_viewer_screen.dart';
import 'package:testkey/custom_camera/photo_count.dart';

class CustomUiExample3 extends StatefulWidget {
  const CustomUiExample3({super.key});

  @override
  State<CustomUiExample3> createState() => _CustomUiExample3State();
}

class _CustomUiExample3State extends State<CustomUiExample3> {
  List<String> capturedPhotos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        actions: const [
          Text(
            'Done',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          SizedBox(width: 10.0)
        ],
      ),
      body: CameraAwesomeBuilder.custom(
        builder: (cameraState, preview) {
          return cameraState.when(
            onPreparingCamera: (state) =>
                const Center(child: CircularProgressIndicator()),
            onPhotoMode: (state) => TakePhotoUI(state, capturedPhotos),
          );
        },
        saveConfig: SaveConfig.photo(),
        bottomActionsBuilder: (state) {
          return AwesomeBottomActions(state: state);
        },
      ),
    );
  }
}

class TakePhotoUI extends StatelessWidget {
  final PhotoCameraState state;
  final List<String> capturedPhotos;

  const TakePhotoUI(this.state, this.capturedPhotos, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          color: Colors.blue[900],
          height: 100.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildGalleryButton(state),
                _buildCaptureButton(state),
                Row(
                  children: [
                    _buildFlashButton(state),
                    _buildImageButton(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGalleryButton(PhotoCameraState state) {
    return StreamBuilder<MediaCapture?>(
      stream: state.captureState$,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return _buildEmptyGalleryPlaceholder(); // Khi chưa có ảnh
        }

        // 📸 Lấy đường dẫn ảnh từ `MediaCapture`
        String filePath = snapshot.data!.captureRequest.when(
          single: (single) => single.file?.path ?? '',
          multiple: (multiple) =>
              multiple.fileBySensor.values.first?.path ?? '',
        );

        getPhotoCount();

        if (filePath.isEmpty) return _buildEmptyGalleryPlaceholder();

        return FutureBuilder<bool>(
          future: File(filePath).exists(),
          builder: (context, fileExists) {
            if (fileExists.connectionState == ConnectionState.waiting) {
              return _buildLoadingGalleryPlaceholder(); // Nếu file chưa có
            }

            if (!fileExists.hasData || !fileExists.data!) {
              return _buildEmptyGalleryPlaceholder(); // Nếu file không tồn tại
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                // ✅ Hiển thị ảnh mới nhất với bo góc
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(filePath),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                // 🎯 Hiển thị số lượng ảnh đã chụp
                Positioned(
                  right: 0,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: StreamBuilder<List<MediaCapture>>(
                      stream: state.captureState$.map((capture) =>
                          capture != null
                              ? [capture]
                              : []), // Lưu danh sách ảnh
                      builder: (context, snapshot) {
                        return const Text(
                          '25',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// 🖼 Placeholder khi chưa có ảnh
  Widget _buildEmptyGalleryPlaceholder() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white38,
          width: 2,
        ),
      ),
    );
  }

  /// 🔄 Placeholder khi đang tải ảnh
  Widget _buildLoadingGalleryPlaceholder() {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      ),
    );
  }

  /// 📸 **Nút chụp ảnh lớn nằm chính giữa**
  Widget _buildImageButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        print('Đã ấn vào image');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ImageViewerScreen(
              ),
            ),
          );
      },
      icon: const Icon(Icons.photo_library, color: Colors.white, size: 30),
    );
  }

  /// ⚡ **Nút bật/tắt flash**
  Widget _buildFlashButton(PhotoCameraState state) {
    return IconButton(
      icon: const Icon(Icons.flash_on, color: Colors.white, size: 30),
      onPressed: () {
        print("⚡ Bật/tắt flash");
      },
    );
  }

  Widget _buildCaptureButton(PhotoCameraState state) {
    return GestureDetector(
      onTap: () => state.takePhoto(),
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
