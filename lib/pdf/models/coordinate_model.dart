import 'dart:ui';

class CoordinateModel {
  final double x;
  final double y;
  final double width;
  final double height;
  final int pageNumber;
  final double zoomLevel;

  CoordinateModel({
    this.x = 50,
    this.y = 50,
    this.width = 120,
    this.height = 50,
    this.pageNumber = 1,
    this.zoomLevel = 1.0,
  });

  CoordinateModel copyWith({
    double? x,
    double? y,
    double? width,
    double? height,
    int? pageNumber,
    double? zoomLevel,
  }) {
    return CoordinateModel(
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      pageNumber: pageNumber ?? this.pageNumber,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }
}

class BoxCalculationInput {
  final CoordinateModel box;
  final Offset scrollOffset;
  final double zoomLevel;

  BoxCalculationInput({
    required this.box,
    required this.scrollOffset,
    required this.zoomLevel,
  });
}
