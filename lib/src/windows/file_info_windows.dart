import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/windows/file_info_windows_ffi_types.dart';
import 'package:win32/win32.dart';
import 'package:image/image.dart' as img;

class FileInfoWindows extends FileInfo {
  FileInfoWindows({FileInfoWindowsFfiTypes? iconExtractor})
      : _iconExtractor = iconExtractor ?? FileInfoWindowsFfiTypesImpl();

  final FileInfoWindowsFfiTypes _iconExtractor;

  static void registerWith() {
    FileInfo.instance = FileInfoWindows();
  }

  Future<Pointer<SHFILEINFO>> _getFileIconInfo(String filePath) async {
    final Pointer<SHFILEINFO> fileInfo = calloc<SHFILEINFO>();

    try {
      _iconExtractor.shGetFileInfo(
        filePath.toNativeUtf16(),
        FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_DIRECTORY,
        fileInfo,
        sizeOf<SHFILEINFO>(),
        SHGFI_FLAGS.SHGFI_ICON |
            SHGFI_FLAGS.SHGFI_SYSICONINDEX |
            SHGFI_FLAGS.SHGFI_SHELLICONSIZE |
            SHGFI_FLAGS.SHGFI_LARGEICON,
      );
      return fileInfo;
    } catch (e) {
      calloc.free(fileInfo);
      rethrow;
    }
  }
}
