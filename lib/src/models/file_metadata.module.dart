import 'package:equatable/equatable.dart';

class FileMetadata extends Equatable {
  final String filePath;
  final String? fileName;
  final String? fileExtension;
  final String? fileType;
  final DateTime? creationTime;
  final DateTime? modifiedTime;
  final DateTime? accessedTime;
  final int? sizeBytes;

  final String? fileSize;

  const FileMetadata({
    required this.filePath,
    this.fileName,
    this.fileExtension,
    this.fileType,
    this.creationTime,
    this.modifiedTime,
    this.accessedTime,
    this.sizeBytes,
    this.fileSize,
  });
  @override
  String toString() => 'FileInfo('
      'filePath: $filePath, '
      'fileName: $fileName, '
      'fileExtension: $fileExtension, '
      'fileType: $fileType, '
      'creationTime: $creationTime, '
      'modifiedTime: $modifiedTime, '
      'accessedTime: $accessedTime, '
      'sizeBytes: $sizeBytes, '
      'fileSize: $fileSize)';
  FileMetadata copyWith({
    String? filePath,
    String? fileName,
    String? fileExtension,
    String? fileType,
    DateTime? creationTime,
    DateTime? modifiedTime,
    DateTime? accessedTime,
    int? sizeBytes,
    String? fileSize,
  }) {
    return FileMetadata(
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      fileExtension: fileExtension ?? this.fileExtension,
      fileType: fileType ?? this.fileType,
      creationTime: creationTime ?? this.creationTime,
      modifiedTime: modifiedTime ?? this.modifiedTime,
      accessedTime: accessedTime ?? this.accessedTime,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      fileSize: fileSize ?? this.fileSize,
    );
  }
  @override
  List<Object?> get props => [
        filePath,
        fileName,
        fileExtension,
        fileType,
        creationTime,
        modifiedTime,
        accessedTime,
        sizeBytes,
        fileSize,
      ];
}
