import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

/// Represents the abstract class for Windows-specific file information FFI types.
///
/// This class provides a common interface for Windows-specific file information FFI types.
/// It serves as a base class for other FFI types related to file information on Windows.
abstract class FileInfoWindowsFfiTypes {
  /// Retrieves information about a file using the Windows Shell API.
  ///
  /// The [filePath] parameter specifies the path to the file for which information is to be retrieved.
  /// The [fileAttributes] parameter specifies the attributes of the file.
  /// Returns an integer value representing the result of the operation.
  int shGetFileInfo(Pointer<Utf16> filePath, int fileAttributes,
      Pointer<SHFILEINFO> fileInfo, int fileInfoSize, int flags);

  /// Retrieves information about the specified icon.
  ///
  /// The [hIcon] parameter specifies the handle to the icon.
  /// The [piconinfo] parameter is a pointer to an [ICONINFO] structure that receives the icon information.
  ///
  /// Returns an integer value indicating the success of the operation.
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

  DynamicLibrary openKernel32();

  int findFirstFile(Pointer<Utf16> pathPtr, Pointer<WIN32_FIND_DATA> findData);
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

  @override
  int getDC(int hwnd) {
    return GetDC(hwnd);
  }

  @override
  int destroyIcon(int hIcon) {
    return DestroyIcon(hIcon);
  }

  @override
  DynamicLibrary openKernel32() {
    if (Platform.isWindows) {
      return DynamicLibrary.open('kernel32.dll');
    } else {
      throw Exception('This code is intended to run on Windows.');
    }
  }

  @override
  int findFirstFile(Pointer<Utf16> pathPtr, Pointer<WIN32_FIND_DATA> findData) {
    return openKernel32().lookupFunction<
            UintPtr Function(Pointer<Utf16> lpFileName,
                Pointer<WIN32_FIND_DATA> lpFindFileData),
            int Function(Pointer<Utf16> lpFileName,
                Pointer<WIN32_FIND_DATA> lpFindFileData)>('FindFirstFileW')(
        pathPtr, findData);
  }
}
