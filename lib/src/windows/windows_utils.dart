import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter_file_info/src/windows/enum/windows_file_attribiutes.dart';
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

  /// Converts a numerical attribute mask into a list of [WindowsFileAttributes].
  ///
  /// This function takes a numerical attribute mask as input and converts it into a list of [WindowsFileAttributes],
  /// representing the individual attributes that are set in the mask. Each attribute in the [WindowsFileAttributes] enum
  /// corresponds to a specific bit in the attribute mask.
  ///
  /// Example usage:
  /// ```dart
  /// int attributeMask = 37; // Binary: 100101
  /// List<FileAttributes> attributes = getFileAttributesFromMask(attributeMask);
  /// print('File Attributes: $attributes'); // Output: [READ_ONLY, ARCHIVE, DEVICE]
  /// ```
  ///
  /// Note: This function is useful for extracting individual attributes from a numerical bitmask, providing a more
  /// convenient representation for understanding the file's characteristics.
  List<WindowsFileAttributes> getFileAttributesFromMask(int attributeMask);

  /// Formats a file size in bytes into a human-readable string representation.
  ///
  /// This function takes a size in bytes as input and converts it into a string with an appropriate unit (KB, MB, GB or TB),
  /// making it more readable for users. The function employs the following conventions:
  ///
  /// - If the size is greater than or equal to 1 TB, the result will be formatted as 'X.XX TB'.
  /// - If the size is between 1 GB and 1 TB (exclusive), the result will be formatted as 'X.XX GB'.
  /// - If the size is between 1 MB and 1 GB (exclusive), the result will be formatted as 'X.XX MB'.
  /// - If the size is between 1 KB and 1 MB (exclusive), the result will be formatted as 'X.XX KB'.
  /// - If the size is less than 1 KB, the result will be '0 KB'.
  ///
  /// Example usage:
  /// ```dart
  /// int fileSize = 2048000; // Size in bytes (2 MB)
  /// String formattedSize = formatFileSize(fileSize);
  /// print('Formatted File Size: $formattedSize'); // Output: '2.00 MB'
  /// ```
  String formatFileSize(int sizeInBytes);
}

class WindowsUtilsImpl implements WindowsUtils {
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
  List<WindowsFileAttributes> getFileAttributesFromMask(int attributeMask) {
    List<WindowsFileAttributes> attributes = [];

    for (var attr in WindowsFileAttributes.values) {
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
