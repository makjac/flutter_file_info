// android_file_attributes.dart

// ignore_for_file: constant_identifier_names

/// Enumeration representing file attributes specific to the Android operating system.
///
/// This enum provides a set of constants that describe various permissions associated with files and directories on Android.
///
/// Usage:
/// ```dart
/// final attribute = AndroidFileAttributes.ownerWrite;
/// print('Attribute: $attribute');
/// ```
enum AndroidFileAttributes {
  /// Execute/search permission, group.
  GROUP_EXECUTE,

  /// Read permission, group.
  GROUP_READ,

  /// Write permission, group.
  GROUP_WRITE,

  /// Execute/search permission, others.
  OTHERS_EXECUTE,

  /// Read permission, others.
  OTHERS_READ,

  /// Write permission, others.
  OTHERS_WRITE,

  /// Execute/search permission, owner.
  OWNER_EXECUTE,

  /// Read permission, owner.
  OWNER_READ,

  /// Write permission, owner.
  OWNER_WRITE
}
class AndroidFileAttributesUtility {
  static Set<AndroidFileAttributes> parseAndroidFileAttributes(
      List<String> attributeNames) {
    return attributeNames
        .map((name) {
          switch (name) {
            case 'GROUP_EXECUTE':
              return AndroidFileAttributes.GROUP_EXECUTE;
            case 'GROUP_READ':
              return AndroidFileAttributes.GROUP_READ;
            case 'GROUP_WRITE':
              return AndroidFileAttributes.GROUP_WRITE;
            case 'OTHERS_EXECUTE':
              return AndroidFileAttributes.OTHERS_EXECUTE;
            case 'OTHERS_READ':
              return AndroidFileAttributes.OTHERS_READ;
            case 'OTHERS_WRITE':
              return AndroidFileAttributes.OTHERS_WRITE;
            case 'OWNER_EXECUTE':
              return AndroidFileAttributes.OWNER_EXECUTE;
            case 'OWNER_READ':
              return AndroidFileAttributes.OWNER_READ;
            case 'OWNER_WRITE':
              return AndroidFileAttributes.OWNER_WRITE;
            default:
              return null;
          }
        })
        .whereType<AndroidFileAttributes>()
        .toSet();
  }
}
