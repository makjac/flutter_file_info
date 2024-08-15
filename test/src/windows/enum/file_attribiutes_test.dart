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

    test('FileAttributes.ARCHIVE has correct value', () {
      expect(FileAttributes.ARCHIVE.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_ARCHIVE);
    });

    test('FileAttributes.DEVICE has correct value', () {
      expect(FileAttributes.DEVICE.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_DEVICE);
    });

    test('FileAttributes.NORMAL has correct value', () {
      expect(FileAttributes.NORMAL.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_NORMAL);
    });

    test('FileAttributes.TEMPORARY has correct value', () {
      expect(FileAttributes.TEMPORARY.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_TEMPORARY);
    });

    test('FileAttributes.SPARSE_FILE has correct value', () {
      expect(FileAttributes.SPARSE_FILE.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_SPARSE_FILE);
    });

    test('FileAttributes.REPARSE_POINT has correct value', () {
      expect(FileAttributes.REPARSE_POINT.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_REPARSE_POINT);
    });

    test('FileAttributes.COMPRESSED has correct value', () {
      expect(FileAttributes.COMPRESSED.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_COMPRESSED);
    });

    test('FileAttributes.OFFLINE has correct value', () {
      expect(FileAttributes.OFFLINE.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_OFFLINE);
    });

    test('FileAttributes.NOT_CONTENT_INDEXED has correct value', () {
      expect(FileAttributes.NOT_CONTENT_INDEXED.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_NOT_CONTENT_INDEXED);
    });

    test('FileAttributes.ENCRYPTED has correct value', () {
      expect(FileAttributes.ENCRYPTED.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_ENCRYPTED);
    });

    test('FileAttributes.VIRTUAL has correct value', () {
      expect(FileAttributes.VIRTUAL.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_VIRTUAL);
    });

    test('FileAttributes.EA has correct value', () {
      expect(
          FileAttributes.EA.value, FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_EA);
    });

    test('FileAttributes.PINNED has correct value', () {
      expect(FileAttributes.PINNED.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_PINNED);
    });

    test('FileAttributes.UNPINNED has correct value', () {
      expect(FileAttributes.UNPINNED.value,
          FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_UNPINNED);
    });
  });
}
