import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_info/flutter_file_info.dart';

abstract class AndroidMethodChannel {
  Future<IconInfo> getFileIcon(String filePath);
}

class AndroidMethodChannelImpl implements AndroidMethodChannel {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_file_info');

  @override
  Future<IconInfo> getFileIcon(String filePath) async {
    final result =
        await methodChannel.invokeMethod('getFileIcon', {'filePath': filePath});

    final Map<String, dynamic> data = Map<String, dynamic>.from(result);

    final String base64Image = data['pixelData'] as String;

    // Ensure base64Image is a valid base64 string
    final Uint8List pixelData;
    try {
      pixelData =
          base64.decode(base64Image.replaceAll('\n', '').replaceAll('\r', ''));
    } catch (e) {
      throw Exception('Failed to decode base64 image data: $e');
    }

    final double width = data['width'] as double;
    final double height = data['height'] as double;

    return IconInfo.fromMap({
      'pixelData': pixelData,
      'width': width,
      'height': height,
    });
  }
}
