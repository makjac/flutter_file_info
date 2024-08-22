enum AndroidFileAttributes {
  GROUP_EXECUTE,
  GROUP_READ,
  GROUP_WRITE,
  OTHERS_EXECUTE,
  OTHERS_READ,
  OTHERS_WRITE,
  OWNER_EXECUTE,
  OWNER_READ,
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
