import 'package:win32/win32.dart';

enum FileAttributes {
  READ_ONLY,
  HIDDEN,
  SYSTEM,
  DIRECTORY,
  ARCHIVE,
  DEVICE,
  NORMAL,
  TEMPORARY,
  SPARSE_FILE,
  REPARSE_POINT,
  COMPRESSED,
  OFFLINE,
  NOT_CONTENT_INDEXED,
  ENCRYPTED,
  VIRTUAL,
  EA,
  /// This attribute indicates user intent that the file or directory should be kept fully present locally even when not being actively accessed.
  PINNED,
  UNPINNED,
  RECALL_ON_OPEN,
  RECALL_ON_DATA_ACCESS,
}
extension FileAttributesExtension on FileAttributes {
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
