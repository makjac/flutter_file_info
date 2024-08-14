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
  });
}
