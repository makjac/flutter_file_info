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
}
