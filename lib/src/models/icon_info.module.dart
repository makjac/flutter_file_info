import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class IconInfo extends Equatable {
  final int width;
  final int height;
  final int colorDepth;
  final Uint8List pixelData;
  const IconInfo({
    required this.width,
    required this.height,
    required this.colorDepth,
    required this.pixelData,
  });
  @override
  String toString() {
    return 'IconInfo(width: $width, height: $height, colorDepth: $colorDepth, pixelData: $pixelData)';
  }

  @override
  List<Object?> get props => [
        width,
        height,
        colorDepth,
        pixelData,
      ];
}
