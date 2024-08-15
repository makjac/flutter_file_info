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

    test('formatFileSize formats file size correctly', () {
      expect(windowsUtils.formatFileSize(1023), '0 KB');
      expect(windowsUtils.formatFileSize(1024), '1.00 KB');
      expect(windowsUtils.formatFileSize(1048575), '1024.00 KB');
      expect(windowsUtils.formatFileSize(1048576), '1.00 MB');
      expect(windowsUtils.formatFileSize(1073741823), '1024.00 MB');
      expect(windowsUtils.formatFileSize(1073741824), '1.00 GB');
      expect(windowsUtils.formatFileSize(1099511627775), '1024.00 GB');
      expect(windowsUtils.formatFileSize(1099511627776), '1.00 TB');
    });
  });
}
