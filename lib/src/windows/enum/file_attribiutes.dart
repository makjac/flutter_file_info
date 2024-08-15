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
