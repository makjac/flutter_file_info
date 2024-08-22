import 'dart:typed_data';

import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/android/android_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'file_info_android_test.mocks.dart';

@GenerateMocks([AndroidMethodChannel])
void main() {
  late MockAndroidMethodChannel mockAndroidMethodChannel;
  late FileInfoAndroid fileInfoAndroid;

  setUp(() {
    mockAndroidMethodChannel = MockAndroidMethodChannel();
    fileInfoAndroid =
        FileInfoAndroid(androidMethodChannel: mockAndroidMethodChannel);
  });

  group('FileInfoAndroid', () {
    test('should return IconInfo from getFileIconInfo', () async {
      const filePath = 'test/path';
      final iconInfo = IconInfo(
        pixelData: Uint8List.fromList([1, 2, 3]),
        width: 100,
        height: 100,
        colorDepth: 0,
      );

      when(mockAndroidMethodChannel.getFileIcon(filePath))
          .thenAnswer((_) async => iconInfo);

      final result = await fileInfoAndroid.getFileIconInfo(filePath);

      expect(result, isNotNull);
      expect(result, iconInfo);
      verify(mockAndroidMethodChannel.getFileIcon(filePath)).called(1);
    });
  });
}
