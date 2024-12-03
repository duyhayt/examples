import 'dart:io';

import 'package:flutter/material.dart';

class FileDropdown extends StatelessWidget {
  final List<File>? files;
  final File? selectedFile;
  final ValueChanged<File?> onFileChanged;

  const FileDropdown({
    super.key,
    required this.files,
    required this.selectedFile,
    required this.onFileChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (files == null || files!.isEmpty) {
      return const SizedBox.shrink();
    }

    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButton<File>(
          isExpanded: true,
          value: selectedFile,
          items: files!
              .map(
                (file) => DropdownMenuItem<File>(
                  value: file,
                  child: Text(
                    file.path.split('/').last,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: onFileChanged,
        ),
      ),
    );
  }
}
