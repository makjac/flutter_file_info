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

/// Utility class for handling Android file attributes.
///
/// This class provides methods for working with Android file attributes, including converting
/// attribute names from strings to their corresponding enum values.
///
/// Example usage:
/// ```dart
/// List<String> attributeNames = ['OWNER_WRITE', 'GROUP_READ'];
/// Set<AndroidFileAttributes> attributes = AndroidFileAttributesUtility.parseAndroidFileAttributes(attributeNames);
/// print(attributes); // Output: {AndroidFileAttributes.OWNER_WRITE, AndroidFileAttributes.GROUP_READ}
/// ```
class AndroidFileAttributesUtility {
  /// Converts a list of attribute names in string format to a set of [AndroidFileAttributes].
  ///
  /// This method takes a list of attribute names as strings and converts each string to its corresponding
  /// [AndroidFileAttributes] enum value. If a string does not match any of the defined attributes, it is ignored.
  ///
  /// [attributeNames] is a list of attribute names in string format. Each string should match one of the
  /// enum names defined in [AndroidFileAttributes].
  ///
  /// Returns a set of [AndroidFileAttributes] corresponding to the provided attribute names. The result is
  /// a set containing only valid attributes that were found in the input list.
  ///
  /// Example usage:
  /// ```dart
  /// List<String> names = ['OWNER_WRITE', 'GROUP_READ', 'INVALID'];
  /// Set<AndroidFileAttributes> attributes = AndroidFileAttributesUtility.parseAndroidFileAttributes(names);
  /// print(attributes); // Output: [AndroidFileAttributes.OWNER_WRITE, AndroidFileAttributes.GROUP_READ]
  /// ```
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
