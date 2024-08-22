import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/android/android_method_channel.dart';

import 'android_method_channel_test.mocks.dart';

// Generowanie mocków
@GenerateMocks([MethodChannel])
void main() {
  // Mocks
  late MockMethodChannel mockMethodChannel;
  late AndroidMethodChannelImpl androidMethodChannelImpl;

  setUp(() {
    mockMethodChannel = MockMethodChannel();
    androidMethodChannelImpl =
        AndroidMethodChannelImpl(methodChannel: mockMethodChannel);
  });

  group('AndroidMethodChannelImpl', () {
    test('getFileIcon returns correct IconInfo', () async {
      // Przygotowanie danych
      const filePath = 'test/path';
      final pixelData = base64.encode(Uint8List.fromList([0, 1, 2, 3]));
      final result = {
        'pixelData': pixelData,
        'width': 100.0,
        'height': 200.0,
      };

      // Mockowanie odpowiedzi
      when(mockMethodChannel
              .invokeMethod('getFileIcon', {'filePath': filePath}))
          .thenAnswer((_) async => result);

      // Wywołanie metody
      final iconInfo = await androidMethodChannelImpl.getFileIcon(filePath);

      // Sprawdzanie wyników
      expect(iconInfo.pixelData, Uint8List.fromList([0, 1, 2, 3]));
      expect(iconInfo.width, 100.0);
      expect(iconInfo.height, 200.0);
    });

    test('getFileIcon throws an exception on invalid base64', () async {
      // Przygotowanie danych
      const filePath = 'test/path';
      final result = {
        'pixelData': 'invalid_base64',
        'width': 100.0,
        'height': 200.0,
      };

      // Mockowanie odpowiedzi
      when(mockMethodChannel
              .invokeMethod('getFileIcon', {'filePath': filePath}))
          .thenAnswer((_) async => result);

      // Wywołanie metody i sprawdzanie, czy rzuca wyjątek
      expect(
        () async => await androidMethodChannelImpl.getFileIcon(filePath),
        throwsA(isA<Exception>()),
      );
    });
  });
}
