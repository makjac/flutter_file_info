import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

abstract class FileInfoWindowsFfiTypes {
  int shGetFileInfo(Pointer<Utf16> filePath, int fileAttributes,
      Pointer<SHFILEINFO> fileInfo, int fileInfoSize, int flags);

  int getIconInfo(int hIcon, Pointer<ICONINFO> piconinfo);

  int getDIBits(
    int hdc,
    int hbmp,
    int uStartScan,
    int cScanLines,
    Pointer lpvBits,
    Pointer<BITMAPINFO> lpbi,
    int uUsage,
  );

  int getDC(int hwnd);

  int destroyIcon(int hIcon);
}

class FileInfoWindowsFfiTypesImpl implements FileInfoWindowsFfiTypes {
  @override
  int shGetFileInfo(Pointer<Utf16> filePath, int fileAttributes,
      Pointer<SHFILEINFO> fileInfo, int fileInfoSize, int flags) {
    return SHGetFileInfo(
        filePath, fileAttributes, fileInfo, fileInfoSize, flags);
  }

  @override
  int getIconInfo(int hIcon, Pointer<ICONINFO> piconinfo) {
    return GetIconInfo(hIcon, piconinfo);
  }

  @override
  int getDIBits(int hdc, int hbmp, int uStartScan, int cScanLines,
      Pointer lpvBits, Pointer<BITMAPINFO> lpbi, int uUsage) {
    return GetDIBits(hdc, hbmp, uStartScan, cScanLines, lpvBits, lpbi, uUsage);
  }
}
