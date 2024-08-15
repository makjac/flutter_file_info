import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter_file_info/src/windows/enum/file_attribiutes.dart';
import 'package:win32/win32.dart';

abstract class WindowsUtils {
  /// Retrieves the type of a file based on its path using the Windows Shell API.
  ///
  /// This function takes a file path as input and uses the Windows Shell API to obtain information about the file,
  /// including its type (e.g., 'Text Document', 'Image File'). The function allocates memory for a [SHFILEINFO] structure,
  /// populates it with information using [SHGetFileInfo], and then extracts the type name from the structure.
  ///
  /// Example usage:
  /// ```dart
  /// String filePath = 'C:\\example\\document.txt';
  /// String fileType = getFileType(filePath);
  /// print('File Type: $fileType');
  /// ```
  ///
  /// Note: The Windows Shell API is used to query file information, providing details such as the type name.
  /// This function is specifically designed for Windows environments.
  ///
  /// See also:
  /// - [SHFILEINFO structure documentation](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/ns-shellapi-shfileinfow)
  /// - [SHGetFileInfo function documentation](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/nf-shellapi-shgetfileinfow)
  String getFileType(String filePath);

  /// Converts a Windows FILETIME structure to a Dart [DateTime] object.
  ///
  /// The Windows FILETIME structure represents the date and time in the file system. This function takes a FILETIME structure
  /// as input and converts it into a Dart [DateTime] object, allowing easier manipulation and display of the date and time.
  ///
  /// The FILETIME structure is a 64-bit value where the low 32 bits represent the number of 100-nanosecond intervals since January 1, 1601,
  /// and the high 32 bits provide additional precision. This function converts this structure to microseconds since epoch, then
  /// constructs a [DateTime] object using [DateTime.fromMicrosecondsSinceEpoch].
  ///
  /// Example usage:
  /// ```dart
  /// FILETIME fileTime = ...; // Some FILETIME structure
  /// DateTime dateTime = convertFileTimeToDateTime(fileTime);
  /// print('Converted DateTime: $dateTime');
  /// ```
  ///
  /// Note: The FILETIME structure is often used in Windows API functions to represent time-related information.
  ///
  /// See also:
  /// - [FILETIME documentation](https://docs.microsoft.com/en-us/windows/win32/api/minwinbase/ns-minwinbase-filetime)
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
