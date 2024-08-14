import 'package:equatable/equatable.dart';

class FileMetadata extends Equatable {
  /// The full path of the file.
  final String filePath;

  /// The name of the file (excluding the path).
  final String? fileName;

  /// The extension of the file.
  final String? fileExtension;

  /// The type of the file, such as 'Text Document' or 'Image File'.
  final String? fileType;

  /// The [DateTime] when the file was created.
  final DateTime? creationTime;

  /// The [DateTime] when the file was last modified.
  final DateTime? modifiedTime;

  /// The [DateTime] when the file was last accessed.
  final DateTime? accessedTime;

  /// The size of the file in bytes.
  final int? sizeBytes;

  /// The size of the file formatted as a human-readable string, e.g., '1.5 GB'.
  final String? fileSize;

  /// Creates a new instance of [FileMetadata] with the specified parameters.
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

  /// Returns a string representation of the [FileMetadata] object.
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

  /// Creates a new [FileMetadata] object with updated values based on the provided parameters.
  ///
  /// Use this method to create a new [FileMetadata] instance with specific fields modified while keeping the original values for the rest.
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
