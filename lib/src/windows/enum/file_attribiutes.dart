// ignore_for_file: constant_identifier_names

import 'package:win32/win32.dart';

/// Enumeration representing file attributes commonly used in Windows systems.
///
/// This enum provides a set of constants that describe various attributes associated with files and directories on the Windows operating system.
/// Each constant represents a specific attribute, such as read-only, hidden, system, etc.
///
/// Usage:
/// ```dart
/// FileAttributes attribute = FileAttributes.READ_ONLY;
/// print('Value of READ_ONLY attribute: ${attribute.value}');
/// ```
enum FileAttributes {
  /// A file that is marked as read-only. Applications can read the file, but cannot write to it or delete it.
  READ_ONLY,

  /// The file or directory is marked as hidden and is not included in an ordinary directory listing.
  HIDDEN,

  /// A file or directory that the operating system uses as part of its functionality or uses exclusively.
  SYSTEM,

  /// The handle that identifies a directory.
  DIRECTORY,

  /// A file or directory that is an archive file or directory. Applications typically use this attribute to mark files for backup or removal.
  ARCHIVE,

  /// This value is reserved for system use.
  DEVICE,

  /// A file that does not have other attributes set.
  NORMAL,

  /// A file that is being used for temporary storage.
  TEMPORARY,

  /// A file that is a sparse file.
  SPARSE_FILE,

  /// A file or directory that has an associated reparse point, or a file that is a symbolic link.
  REPARSE_POINT,

  /// A file or directory that is compressed. For a file, all of the data in the file is compressed.
  COMPRESSED,

  /// The data of a file is not available immediately. This attribute indicates that the file data is physically moved to offline storage.
  OFFLINE,

  /// The file or directory is not to be indexed by the content indexing service.
  NOT_CONTENT_INDEXED,

  /// A file or directory that is encrypted. For a file, all data streams in the file are encrypted.
  ENCRYPTED,

  /// This value is reserved for system use.
  VIRTUAL,

  /// A file or directory with extended attributes. (For internal use only.)
  EA,

  /// This attribute indicates user intent that the file or directory should be kept fully present locally even when not being actively accessed.
  PINNED,

  /// This attribute indicates that the file or directory should not be kept fully present locally except when being actively accessed.
  UNPINNED,

  /// This attribute only appears in directory enumeration classes. When set, it means that the file or directory has no physical representation on the local system; the item is virtual.
  RECALL_ON_OPEN,

  /// When this attribute is set, it means that the file or directory is not fully present locally.
  RECALL_ON_DATA_ACCESS,
}

/// Extension methods for the [FileAttributes] enum.
///
/// See also:
/// - [File Attribute Constants](https://learn.microsoft.com/en-us/windows/win32/fileio/file-attribute-constants)
extension FileAttributesExtension on FileAttributes {
  /// Returns the corresponding numerical value for the Windows file attribute.
  int get value {
    switch (this) {
      case FileAttributes.READ_ONLY:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_READONLY;
      case FileAttributes.HIDDEN:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_HIDDEN;
      case FileAttributes.SYSTEM:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_SYSTEM;
      case FileAttributes.DIRECTORY:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_DIRECTORY;
      case FileAttributes.ARCHIVE:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_ARCHIVE;
      case FileAttributes.DEVICE:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_DEVICE;
      case FileAttributes.NORMAL:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_NORMAL;
      case FileAttributes.TEMPORARY:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_TEMPORARY;
      case FileAttributes.SPARSE_FILE:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_SPARSE_FILE;
      case FileAttributes.REPARSE_POINT:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_REPARSE_POINT;
      case FileAttributes.COMPRESSED:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_COMPRESSED;
      case FileAttributes.OFFLINE:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_OFFLINE;
      case FileAttributes.NOT_CONTENT_INDEXED:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_NOT_CONTENT_INDEXED;
      case FileAttributes.ENCRYPTED:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_ENCRYPTED;
      case FileAttributes.VIRTUAL:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_VIRTUAL;
      case FileAttributes.EA:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_EA;
      case FileAttributes.PINNED:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_PINNED;
      case FileAttributes.UNPINNED:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_UNPINNED;
      case FileAttributes.RECALL_ON_OPEN:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_RECALL_ON_OPEN;
      case FileAttributes.RECALL_ON_DATA_ACCESS:
        return FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS;
    }
  }
}
