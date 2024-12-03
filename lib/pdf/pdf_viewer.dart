import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:testkey/pdf/models/coordinate_model.dart';
import 'package:testkey/pdf/widgets/corner_handler_widget.dart';
import 'package:testkey/pdf/widgets/decorated_box_widget.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  CoordinateModel box = CoordinateModel();
  List<CoordinateModel> boxes = <CoordinateModel>[];
  List<File>? _files;
  File? _selectedFile;
  final GlobalKey _pdfViewerKey = GlobalKey<SfPdfViewerState>();
  late final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
    _pdfViewerController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });
  }

  Future<List<File>?> _uploadPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf'], allowMultiple: true);

    if (result != null) {
      setState(() {
        _files = result.paths.map((path) => File(path!)).toList();
        _selectedFile = _files!.first;
      });
      return _files;
    } else {
      throw Exception('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
        bottom: _files != null && _files!.isNotEmpty
            ? PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<File>(
                    isExpanded: true,
                    value: _selectedFile,
                    items: _files!
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
                    onChanged: (File? newValue) {
                      setState(() {
                        _selectedFile = newValue;
                      });
                    },
                  ),
                ),
              )
            : null,
      ),
      body: _selectedFile == null
          ? const Center(child: Text('No file selected'))
          : Stack(
              children: [
                SfPdfViewer.file(
                  _selectedFile!,
                  key: _pdfViewerKey,
                  scrollDirection: PdfScrollDirection.vertical,
                  controller: _pdfViewerController,
                  pageSpacing: 1,
                  canShowScrollHead: false,
                  canShowPaginationDialog: false,
                  enableDoubleTapZooming: false,
                  interactionMode: PdfInteractionMode.pan,
                  pageLayoutMode: PdfPageLayoutMode.continuous,
                  onPageChanged: (_) => setState(() {}),
                  onZoomLevelChanged: (_) => setState(() {}),
                ),
                _buildBox(),
              ],
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.save_alt_sharp),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.pending_actions),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadPdf,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBox() {
    return TransformableBox(
      rect: Rect.fromLTWH(
        (box.x - _pdfViewerController.scrollOffset.dx) *
            _pdfViewerController.zoomLevel,
        (box.y - _pdfViewerController.scrollOffset.dy) *
            _pdfViewerController.zoomLevel,
        box.width * _pdfViewerController.zoomLevel,
        box.height * _pdfViewerController.zoomLevel,
      ),
      resizable: true,
      allowFlippingWhileResizing: false,
      flip: Flip.none,
      onChanged: (result, event) {
        setState(() {
          box = box.copyWith(
            x: (result.rect.left / _pdfViewerController.zoomLevel) +
                _pdfViewerController.scrollOffset.dx,
            y: (result.rect.top / _pdfViewerController.zoomLevel) +
                _pdfViewerController.scrollOffset.dy,
            width: result.rect.width / _pdfViewerController.zoomLevel,
            height: result.rect.height / _pdfViewerController.zoomLevel,
            pageNumber: _pdfViewerController.pageNumber,
          );
        });
      },
      contentBuilder: (context, rect, flip) => const DecoratedBoxWidget(),
      visibleHandles: const {...HandlePosition.corners},
      cornerHandleBuilder: (context, handle) =>
          CornerHandlerWidget(handle: handle),
    );
  }
}
