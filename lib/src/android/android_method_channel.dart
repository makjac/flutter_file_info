import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_info/flutter_file_info.dart';

abstract class AndroidMethodChannel {
  Future<IconInfo> getFileIcon(String filePath);
}
