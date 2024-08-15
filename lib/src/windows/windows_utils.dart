import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter_file_info/src/windows/enum/file_attribiutes.dart';
import 'package:win32/win32.dart';

abstract class WindowsUtils {
  String getFileType(String filePath);
  DateTime convertFileTimeToDateTime(FILETIME fileTime);
  List<FileAttributes> getFileAttributesFromMask(int attributeMask);
  String formatFileSize(int sizeInBytes);
}

class WindowsUtilsImpl extends WindowsUtils {
  @override
  String getFileType(String filePath) {
    final Pointer<SHFILEINFO> fileInfo = calloc<SHFILEINFO>();

    try {
      final pathPtr = filePath.toNativeUtf16();

      SHGetFileInfo(pathPtr, 0, fileInfo, sizeOf<SHFILEINFO>(),
          SHGFI_FLAGS.SHGFI_TYPENAME | SHGFI_FLAGS.SHGFI_USEFILEATTRIBUTES);
    } finally {
      calloc.free(fileInfo);
    }

    return fileInfo.ref.szTypeName;
  }

  @override
  DateTime convertFileTimeToDateTime(FILETIME fileTime) {
    final int64Value = (fileTime.dwHighDateTime << 32) | fileTime.dwLowDateTime;

    final microsecondsSinceEpoch = int64Value / 10 - 11644473600000000;

    return DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch.round());
  }

  @override
  List<FileAttributes> getFileAttributesFromMask(int attributeMask) {
    List<FileAttributes> attributes = [];

    for (var attr in FileAttributes.values) {
      if (attributeMask & attr.value != 0) {
        attributes.add(attr);
      }
    }

    return attributes;
  }

  @override
  String formatFileSize(int sizeInBytes) {
    const int kb = 1024;
    const int mb = kb * 1024;
    const int gb = mb * 1024;
    const int tb = gb * 1024;

    if (sizeInBytes >= tb) {
      return '${(sizeInBytes / tb).toStringAsFixed(2)} TB';
    } else if (sizeInBytes >= gb) {
      return '${(sizeInBytes / gb).toStringAsFixed(2)} GB';
    } else if (sizeInBytes >= mb) {
      return '${(sizeInBytes / mb).toStringAsFixed(2)} MB';
    } else if (sizeInBytes >= kb) {
      return '${(sizeInBytes / kb).toStringAsFixed(2)} KB';
    } else {
      return '0 KB';
    }
  }
  }
