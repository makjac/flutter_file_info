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
