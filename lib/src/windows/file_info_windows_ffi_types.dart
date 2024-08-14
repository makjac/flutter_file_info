import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

abstract class FileInfoWindowsFfiTypes {
  int shGetFileInfo(Pointer<Utf16> filePath, int fileAttributes,
      Pointer<SHFILEINFO> fileInfo, int fileInfoSize, int flags);

  int getIconInfo(int hIcon, Pointer<ICONINFO> piconinfo);
}
