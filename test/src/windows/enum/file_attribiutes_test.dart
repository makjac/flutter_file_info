import 'package:flutter_file_info/src/windows/enum/file_attribiutes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:win32/win32.dart';

void main() {
  group('FileAttributes enum tests', () {
    test('FileAttributes.READ_ONLY has correct value', () {
      expect(FileAttributes.READ_ONLY.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_READONLY);
    });

    test('FileAttributes.HIDDEN has correct value', () {
      expect(FileAttributes.HIDDEN.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_HIDDEN);
    });

    test('FileAttributes.SYSTEM has correct value', () {
      expect(FileAttributes.SYSTEM.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_SYSTEM);
    });

    test('FileAttributes.DIRECTORY has correct value', () {
      expect(FileAttributes.DIRECTORY.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_DIRECTORY);
    });
  });
}
