import 'dart:typed_data';

import 'package:equatable/equatable.dart';

/// Represents information about an icon, including its dimensions, color depth, and pixel data.
///
/// This class is used to encapsulate data extracted from an icon, providing a convenient
/// way to access and manipulate icon information.
class IconInfo extends Equatable {
  /// The width of the icon in pixels.
  final int width;

  /// The height of the icon in pixels.
  final int height;

  /// The color depth of the icon, indicating the number of bits per pixel.
  final int colorDepth;

  /// A Uint8List representing the pixel data of the icon.
  final Uint8List pixelData;

  /// Creates an instance of the [IconInfo] class with the specified parameters.
  ///
  /// The [width], [height], [colorDepth], and [pixelData] parameters are required.
  const IconInfo({
    required this.width,
    required this.height,
    required this.colorDepth,
    required this.pixelData,
  });

  /// Generates a human-readable string representation of the [IconInfo] object.
  ///
  /// The string includes information about the icon's width, height, color depth, and pixel data.
  @override
  String toString() {
    return 'IconInfo(width: $width, height: $height, colorDepth: $colorDepth, pixelData: $pixelData)';
  }

  /// Creates a copy of the [IconInfo] object with optional modifications to its properties.
  ///
  /// Parameters:
  ///   - `width`: New width for the copied icon (defaults to the original width if not provided).
  ///   - `height`: New height for the copied icon (defaults to the original height if not provided).
  ///   - `colorDepth`: New color depth for the copied icon (defaults to the original color depth if not provided).
  ///   - `pixelData`: New pixel data for the copied icon (defaults to the original pixel data if not provided).
  ///
  /// Returns a new [IconInfo] object with the specified modifications.
  copyWith({
    int? width,
    int? height,
    int? colorDepth,
    Uint8List? pixelData,
  }) {
    return IconInfo(
      width: width ?? this.width,
      height: height ?? this.height,
      colorDepth: colorDepth ?? this.colorDepth,
      pixelData: pixelData ?? this.pixelData,
    );
  }

  @override
  List<Object?> get props => [
        width,
        height,
        colorDepth,
        pixelData,
      ];
}
