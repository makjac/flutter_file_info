import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/ios/enum/ios_file_attribute.dart';

/// Represents an abstract class for an iOS method channel.
///
/// This class provides a common interface for interacting with iOS platform-specific code
/// through method channels. It serves as a base class for implementing specific iOS method channels.
/// Subclasses should override the methods defined in this class to provide platform-specific functionality.
abstract class IOSMethodChannel {
  /// Retrieves the icon information for a file located at the specified [filePath].
  ///
  /// Returns a [Future] that completes with an [IconInfo] object containing the icon information.
  Future<IconInfo?> getFileIcon(String filePath);

  /// Retrieves the file metadata for a file located at the specified [filePath].
  ///
  /// Returns a [Future] that completes with a [FileMetadata] object containing the file metadata.
  Future<FileMetadata?> getFileInfo(String filePath);
}

class IOSMethodChannelImpl implements IOSMethodChannel {
  IOSMethodChannelImpl({MethodChannel? methodChannel})
      : methodChannel =
            methodChannel ?? const MethodChannel('flutter_file_info');

  @visibleForTesting
  final MethodChannel methodChannel;

  @override
  Future<IconInfo?> getFileIcon(String filePath) async {
    try {
      final result = await methodChannel
          .invokeMethod('getFileIcon', {'filePath': filePath});

      final Map<String, dynamic> data = Map<String, dynamic>.from(result);

      return IconInfo.fromMap(data);
    } on PlatformException catch (e) {
      debugPrint('Error: ${e.message}');
      return null;
    }
  }

  @override
  Future<FileMetadata?> getFileInfo(String filePath) async {
    try {
      final result = await methodChannel
          .invokeMethod('getFileInfo', {'filePath': filePath});

      final Map<String, dynamic> data = Map<String, dynamic>.from(result);

      return FileMetadata(
        filePath: data['filePath'] as String,
        fileName: data['fileName'] as String?,
        fileExtension: data['fileExtension'] as String?,
        fileType: data['fileType'] as String?,
        creationTime: data['creationTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(data['creationTime'] as int)
            : null,
        modifiedTime: data['modifiedTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(data['modifiedTime'] as int)
            : null,
        accessedTime: data['accessedTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(data['accessedTime'] as int)
            : null,
        sizeBytes: data['sizeBytes'] as int?,
        fileSize: data['fileSize'] as String?,
        iosAttributes: _parseIOSAttributes(
          List<String>.from(data['iOSAttributes'] as List<dynamic>),
        ),
      );
    } on PlatformException catch (e) {
      debugPrint('Error: ${e.message}');
      return null;
    }
  }

  List<IosFileAttribute> _parseIOSAttributes(List<String> attributes) {
    return attributes.map((attr) {
      return IosFileAttribute.values.firstWhere((element) {
        return element.name == attr;
      });
    }).toList();
  }
}
