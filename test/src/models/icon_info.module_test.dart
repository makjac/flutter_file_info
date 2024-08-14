import 'dart:typed_data';
import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IconInfo Tests', () {
    test('IconInfo constructor initializes correctly', () {
      final pixelData = Uint8List.fromList([0, 1, 2, 3, 4]);

      final iconInfo = IconInfo(
        width: 32,
        height: 32,
        colorDepth: 24,
        pixelData: pixelData,
      );

      expect(iconInfo.width, 32);
      expect(iconInfo.height, 32);
      expect(iconInfo.colorDepth, 24);
      expect(iconInfo.pixelData, pixelData);
    });

    test('IconInfo copyWith creates a new instance with updated values', () {
      final pixelData = Uint8List.fromList([0, 1, 2, 3, 4]);
      final newPixelData = Uint8List.fromList([5, 6, 7, 8, 9]);

      final iconInfo = IconInfo(
        width: 32,
        height: 32,
        colorDepth: 24,
        pixelData: pixelData,
      );

      final updatedIconInfo = iconInfo.copyWith(
        width: 64,
        pixelData: newPixelData,
      );

      expect(updatedIconInfo.width, 64);
      expect(updatedIconInfo.height, 32); // should remain the same
      expect(updatedIconInfo.colorDepth, 24); // should remain the same
      expect(updatedIconInfo.pixelData, newPixelData);
    });
  });
}
