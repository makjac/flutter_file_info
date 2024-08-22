import 'package:equatable/equatable.dart';
import 'package:flutter_file_info/flutter_file_info.dart';

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

  /// The Windows file attributes represented as a numerical bitmask.
  final int? dwFileAttributes;

  /// The list of Windows file attributes.
  final List<WindowsFileAttributes>? winAttributes;

  /// The list of Android file attributes.
  final List<AndroidFileAttributes>? androidAttributes;

  /// Represents the metadata of a file.
  ///
  /// This class contains information about the attributes of a file.
  /// The [winAttributes] property is a list of [WindowsFileAttributes] that represents
  /// the Windows-specific attributes of the file.
  /// The [androidAttributes] property is a list of [AndroidFileAttributes] that represents
  /// the Android-specific attributes of the file.
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
    this.dwFileAttributes,
    this.winAttributes,
    this.androidAttributes,
  });

  /// Returns a string representation of the [FileMetadata] object.
  @override
  String toString() => 'FileMetadata('
      'filePath: $filePath, '
      'fileName: $fileName, '
      'fileExtension: $fileExtension, '
      'fileType: $fileType, '
      'creationTime: $creationTime, '
      'modifiedTime: $modifiedTime, '
      'accessedTime: $accessedTime, '
      'sizeBytes: $sizeBytes, '
      'fileSize: $fileSize, '
      'dwFileAttributes: $dwFileAttributes, '
      'winAttributes: $winAttributes, '
      'androidAttributes: $androidAttributes)';

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
    int? dwFileAttributes,
    List<WindowsFileAttributes>? winAttributes,
    List<AndroidFileAttributes>? androidAttributes,
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
      dwFileAttributes: dwFileAttributes ?? this.dwFileAttributes,
      winAttributes: winAttributes ?? this.winAttributes,
      androidAttributes: androidAttributes ?? this.androidAttributes,
    );
  }

  /// Returns a list of properties of the [FileMetadata] object used for equality comparison.
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
        dwFileAttributes,
        winAttributes,
        androidAttributes,
      ];
}
