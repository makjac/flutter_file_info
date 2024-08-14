import 'package:flutter_file_info/src/models/file_metadata.module.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FileInfo Tests', () {
    test('FileInfo constructor initializes correctly', () {
      final fileInfo = FileMetadata(
        filePath: 'C:/test/file.txt',
        fileName: 'file.txt',
        fileExtension: '.txt',
        fileType: 'Text Document',
        creationTime: DateTime(2023, 8, 10),
        modifiedTime: DateTime(2023, 8, 12),
        accessedTime: DateTime(2023, 8, 13),
        sizeBytes: 1024,
        fileSize: '1 KB',
      );

      expect(fileInfo.filePath, 'C:/test/file.txt');
      expect(fileInfo.fileName, 'file.txt');
      expect(fileInfo.fileExtension, '.txt');
      expect(fileInfo.fileType, 'Text Document');
      expect(fileInfo.creationTime, DateTime(2023, 8, 10));
      expect(fileInfo.modifiedTime, DateTime(2023, 8, 12));
      expect(fileInfo.accessedTime, DateTime(2023, 8, 13));
      expect(fileInfo.sizeBytes, 1024);
      expect(fileInfo.fileSize, '1 KB');
    });

    test('FileInfo copyWith creates a new instance with updated values', () {
      final fileInfo = FileMetadata(
        filePath: 'C:/test/file.txt',
        fileName: 'file.txt',
        fileExtension: '.txt',
        fileType: 'Text Document',
        creationTime: DateTime(2023, 8, 10),
        modifiedTime: DateTime(2023, 8, 12),
        accessedTime: DateTime(2023, 8, 13),
        sizeBytes: 1024,
        fileSize: '1 KB',
      );

      final updatedFileInfo = fileInfo.copyWith(
        fileName: 'new_file.txt',
        sizeBytes: 2048,
      );

      expect(updatedFileInfo.filePath, 'C:/test/file.txt');
      expect(updatedFileInfo.fileName, 'new_file.txt');
      expect(updatedFileInfo.fileExtension, '.txt');
      expect(updatedFileInfo.fileType, 'Text Document');
      expect(updatedFileInfo.creationTime, DateTime(2023, 8, 10));
      expect(updatedFileInfo.modifiedTime, DateTime(2023, 8, 12));
      expect(updatedFileInfo.accessedTime, DateTime(2023, 8, 13));
      expect(updatedFileInfo.sizeBytes, 2048);
      expect(updatedFileInfo.fileSize, '1 KB');
    });

    test('FileInfo toString returns correct string representation', () {
      final fileInfo = FileMetadata(
        filePath: 'C:/test/file.txt',
        fileName: 'file.txt',
        fileExtension: '.txt',
        fileType: 'Text Document',
        creationTime: DateTime(2023, 8, 10),
        modifiedTime: DateTime(2023, 8, 12),
        accessedTime: DateTime(2023, 8, 13),
        sizeBytes: 1024,
        fileSize: '1 KB',
      );

      expect(
        fileInfo.toString(),
        'FileInfo(filePath: C:/test/file.txt, fileName: file.txt, fileExtension: .txt, fileType: Text Document, creationTime: 2023-08-10 00:00:00.000, modifiedTime: 2023-08-12 00:00:00.000, accessedTime: 2023-08-13 00:00:00.000, sizeBytes: 1024, fileSize: 1 KB)',
      );
    });

    test('FileInfo equality comparison works correctly', () {
      final fileInfo1 = FileMetadata(
        filePath: 'C:/test/file.txt',
        fileName: 'file.txt',
        fileExtension: '.txt',
        fileType: 'Text Document',
        creationTime: DateTime(2023, 8, 10),
        modifiedTime: DateTime(2023, 8, 12),
        accessedTime: DateTime(2023, 8, 13),
        sizeBytes: 1024,
        fileSize: '1 KB',
      );

      final fileInfo2 = FileMetadata(
        filePath: 'C:/test/file.txt',
        fileName: 'file.txt',
        fileExtension: '.txt',
        fileType: 'Text Document',
        creationTime: DateTime(2023, 8, 10),
        modifiedTime: DateTime(2023, 8, 12),
        accessedTime: DateTime(2023, 8, 13),
        sizeBytes: 1024,
        fileSize: '1 KB',
      );

      final fileInfo3 = FileMetadata(
        filePath: 'D:/test/file.txt',
        fileName: 'file.txt',
        fileExtension: '.txt',
        fileType: 'Text Document',
        creationTime: DateTime(2023, 8, 10),
        modifiedTime: DateTime(2023, 8, 12),
        accessedTime: DateTime(2023, 8, 13),
        sizeBytes: 1024,
        fileSize: '1 KB',
      );

      expect(fileInfo1, equals(fileInfo2));
      expect(fileInfo1, isNot(equals(fileInfo3)));
    });
  });
}
