import 'package:flutter_file_info/src/windows/enum/file_attribiutes.dart';
import 'package:flutter_file_info/src/windows/windows_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final windowsUtils = WindowsUtilsImpl();

  group('WindowsUtilsImpl tests', () {
    test('getFileType returns correct file type', () {
      const filePath = 'C:\\example.txt';
      final fileType = windowsUtils.getFileType(filePath);

      expect(fileType, isNotEmpty);
    });
  });
}
