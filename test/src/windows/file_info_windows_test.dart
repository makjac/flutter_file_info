import 'dart:ffi';

import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/windows/file_info_windows_ffi_types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'file_info_windows_test.mocks.dart';

@GenerateMocks([FileInfoWindowsFfiTypes])
void main() {
  group('getFileIconInfo', () {
    late FileInfoWindows tService;
    late MockFileInfoWindowsFfiTypes mockExtractor;

    setUp(() {
      mockExtractor = MockFileInfoWindowsFfiTypes();
      tService = FileInfoWindows(iconExtractor: mockExtractor);
    });

    test('should return IconInfo when everything is successful', () async {
      const filePath = 'path/to/file';

      final Pointer<Utf16> mockFilePath = filePath.toNativeUtf16();
      final Pointer<SHFILEINFO> mockFileInfo = calloc<SHFILEINFO>();

      when(mockExtractor.shGetFileInfo(any, any, any, any, any)).thenReturn(1);
      when(mockExtractor.getIconInfo(any, any)).thenReturn(1);
      when(mockExtractor.getDIBits(any, any, any, any, any, any, any))
          .thenReturn(1);
      when(mockExtractor.getDC(any)).thenReturn(1);

      final result = await tService.getFileIconInfo(filePath);

      expect(result, isNotNull);
      verify(mockExtractor.shGetFileInfo(argThat(isA<Pointer<Utf16>>()), any,
              argThat(isA<Pointer<SHFILEINFO>>()), any, any))
          .called(1);

      calloc.free(mockFilePath);
      calloc.free(mockFileInfo);
    });

    test('should return null when SHGetFileInfo fails', () async {
      const filePath = 'path/to/file';

      final Pointer<Utf16> mockFilePath = filePath.toNativeUtf16();
      final Pointer<SHFILEINFO> mockFileInfo = calloc<SHFILEINFO>();

      when(mockExtractor.shGetFileInfo(any, any, any, any, any)).thenReturn(0);

      final result = await tService.getFileIconInfo(filePath);

      expect(result, isNull);

      calloc.free(mockFilePath);
      calloc.free(mockFileInfo);
    });
  });
}
