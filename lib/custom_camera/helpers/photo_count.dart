import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// 📸 **Hàm đếm số lượng ảnh trong thư mục `camerawesome/`**
Future<int> getPhotoCount() async {
  final directory = await getTemporaryDirectory(); // Lấy thư mục Cache
  final String path = '${directory.path}/camerawesome';

  final dir = Directory(path);
  if (await dir.exists()) {
    List<FileSystemEntity> files = dir.listSync();

    List<FileSystemEntity> images = files
        .where(
            (file) => file.path.endsWith('.jpg') || file.path.endsWith('.png'))
        .toList();

    print(images.length);

    return images.length;
  }
  return 0; 
}

// Clear file trong thư mục `camerawesome/`
Future<void> clearPhotos() async {
  final directory = await getTemporaryDirectory(); // Lấy thư mục Cache
  final String path = '${directory.path}/camerawesome';

  final dir = Directory(path);
  if (await dir.exists()) {
    await dir.delete(recursive: true);
  }
}