import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AndroidFileAttributesUtility', () {
    test('parses valid attribute names correctly', () {
      final attributeNames = [
        'GROUP_EXECUTE',
        'GROUP_READ',
        'GROUP_WRITE',
        'OTHERS_EXECUTE',
        'OTHERS_READ',
        'OTHERS_WRITE',
        'OWNER_EXECUTE',
        'OWNER_READ',
        'OWNER_WRITE'
      ];

      final result = AndroidFileAttributesUtility.parseAndroidFileAttributes(
          attributeNames);

      expect(
          result,
          containsAll([
            AndroidFileAttributes.GROUP_EXECUTE,
            AndroidFileAttributes.GROUP_READ,
            AndroidFileAttributes.GROUP_WRITE,
            AndroidFileAttributes.OTHERS_EXECUTE,
            AndroidFileAttributes.OTHERS_READ,
            AndroidFileAttributes.OTHERS_WRITE,
            AndroidFileAttributes.OWNER_EXECUTE,
            AndroidFileAttributes.OWNER_READ,
            AndroidFileAttributes.OWNER_WRITE
          ]));
      expect(result.length, 9);
    });

    test('ignores invalid attribute names', () {
      final attributeNames = [
        'GROUP_EXECUTE',
        'INVALID_ATTRIBUTE',
        'OWNER_WRITE',
        'ANOTHER_INVALID'
      ];

      final result = AndroidFileAttributesUtility.parseAndroidFileAttributes(
          attributeNames);

      expect(
          result,
          containsAll([
            AndroidFileAttributes.GROUP_EXECUTE,
            AndroidFileAttributes.OWNER_WRITE
          ]));
      expect(result.length, 2);
    });

    test('returns empty set for empty input', () {
      final result =
          AndroidFileAttributesUtility.parseAndroidFileAttributes([]);

      expect(result, isEmpty);
    });

    test('returns empty set for all invalid names', () {
      final attributeNames = ['INVALID', 'ANOTHER_INVALID'];

      final result = AndroidFileAttributesUtility.parseAndroidFileAttributes(
          attributeNames);

      expect(result, isEmpty);
    });

    test('handles mixed valid and invalid attribute names', () {
      final attributeNames = [
        'OWNER_EXECUTE',
        'INVALID',
        'OTHERS_READ',
        'ANOTHER_INVALID'
      ];

      final result = AndroidFileAttributesUtility.parseAndroidFileAttributes(
          attributeNames);

      expect(
          result,
          containsAll([
            AndroidFileAttributes.OWNER_EXECUTE,
            AndroidFileAttributes.OTHERS_READ
          ]));
      expect(result.length, 2);
    });
  });
}
