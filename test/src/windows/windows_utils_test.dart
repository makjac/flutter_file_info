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

    test(
        'getFileAttributesFromMask converts attribute mask to list of FileAttributes',
        () {
      const attributeMask = 37;
      final attributes = windowsUtils.getFileAttributesFromMask(attributeMask);

      expect(
          attributes,
          containsAll([
            FileAttributes.READ_ONLY,
            FileAttributes.SYSTEM,
            FileAttributes.ARCHIVE,
          ]));
      expect(attributes, isNot(contains(FileAttributes.HIDDEN)));
    });
  });
}
