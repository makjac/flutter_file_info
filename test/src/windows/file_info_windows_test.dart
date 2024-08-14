import 'dart:ffi';

import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/windows/file_info_windows_ffi_types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'file_info_windows_test.mocks.dart';

@GenerateMocks([FileInfoWindowsFfiTypes])
void main() {
}
