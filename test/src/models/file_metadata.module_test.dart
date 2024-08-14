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

  });
}
