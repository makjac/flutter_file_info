import 'dart:ffi';

import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/windows/file_info_windows_ffi_types.dart';
import 'package:flutter_file_info/src/windows/windows_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'file_info_windows_test.mocks.dart';

@GenerateMocks([
  FileInfoWindowsFfiTypes,
  WindowsUtils,
])
void main() {
  late FileInfoWindows tService;
  late MockFileInfoWindowsFfiTypes mockFfiTypes;
  late MockWindowsUtils mockWindowsUtils;

  setUp(() {
    mockFfiTypes = MockFileInfoWindowsFfiTypes();
    mockWindowsUtils = MockWindowsUtils();
    tService = FileInfoWindows(
      iconExtractor: mockFfiTypes,
      windowsUtils: mockWindowsUtils,
    );
  });
  group('getFileIconInfo', () {
    test('should return IconInfo when everything is successful', () async {
      const filePath = 'path/to/file';

      final Pointer<Utf16> mockFilePath = filePath.toNativeUtf16();
      final Pointer<SHFILEINFO> mockFileInfo = calloc<SHFILEINFO>();

      when(mockFfiTypes.shGetFileInfo(any, any, any, any, any)).thenReturn(1);
      when(mockFfiTypes.getIconInfo(any, any)).thenReturn(1);
      when(mockFfiTypes.getDIBits(any, any, any, any, any, any, any))
          .thenReturn(1);
      when(mockFfiTypes.getDC(any)).thenReturn(1);

      final result = await tService.getFileIconInfo(filePath);

      expect(result, isNotNull);
      verify(mockFfiTypes.shGetFileInfo(argThat(isA<Pointer<Utf16>>()), any,
              argThat(isA<Pointer<SHFILEINFO>>()), any, any))
          .called(1);

      calloc.free(mockFilePath);
      calloc.free(mockFileInfo);
    });

    test('should return null when SHGetFileInfo fails', () async {
      const filePath = 'path/to/file';

      final Pointer<Utf16> mockFilePath = filePath.toNativeUtf16();
      final Pointer<SHFILEINFO> mockFileInfo = calloc<SHFILEINFO>();

      when(mockFfiTypes.shGetFileInfo(any, any, any, any, any)).thenReturn(0);

      final result = await tService.getFileIconInfo(filePath);

      expect(result, isNull);

      calloc.free(mockFilePath);
      calloc.free(mockFileInfo);
    });
  });

  group('File Info Methods', () {
    test('getFileInfo returns valid FileMetadata', () async {
      const filePath = 'C:\\test\\file.txt';
      final tDate = DateTime(2022, 1, 1);

      when(mockFfiTypes.findFirstFile(any, any)).thenReturn(1);

      when(mockWindowsUtils.getFileType(any)).thenReturn('Text File');
      when(mockWindowsUtils.convertFileTimeToDateTime(any)).thenReturn(tDate);
      when(mockWindowsUtils.formatFileSize(any)).thenReturn('1 KB');
      when(mockWindowsUtils.getFileAttributesFromMask(any))
          .thenReturn([FileAttributes.ARCHIVE]);

      final result = await tService.getFileInfo(filePath);

      expect(result, isNotNull);
      expect(result!.fileType, equals('Text File'));
      expect(result.fileExtension, equals('txt'));
      expect(result.filePath, equals('C:\\test\\file.txt'));
      expect(result.fileSize, equals('1 KB'));
      expect(result.creationTime, equals(tDate));
      expect(result.modifiedTime, equals(tDate));
      expect(result.accessedTime, equals(tDate));
      expect(result.attributes, equals([FileAttributes.ARCHIVE]));
    });

    test('getFileInfo returns null when FindFirstFile fails', () async {
      const filePath = 'C:\\test\\file.txt';

      when(mockFfiTypes.findFirstFile(any, any)).thenReturn(0);

      final result = await tService.getFileInfo(filePath);

      expect(result, isNull);
    });
  });
}
