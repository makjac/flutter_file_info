/// Enumeration representing file attributes specific to the iOS operating system.
///
/// This enum provides a set of constants that describe various permissions associated with files and directories on iOS.
enum IosFileAttribute {
  /// Indicates whether the resource is an application.
  application,

  /// packaged directories.
  package,

  /// Resources normally not displayed to users.
  hidden,

  /// This process (as determined by EUID) can read the resource.
  readable,

  /// This process (as determined by EUID) can write to the resource.
  writable,

  /// System-immutable resources.
  systemImmutable,

  /// User-immutable resources.
  userImmutable,

  /// Resource should be excluded from backups.
  excludedFromBackup,

  /// Resource is a directory.
  directory,

  /// Indicates whether the resource is a regular file.
  regularFile,

  /// Resource is a symbolic link.
  symbolicLink,

  /// Indicates whether this URL is a file system trigger directory.
  mountTrigger,

  /// Indicates whether the root directory is a volume.
  volume,

  /// The resource is a Finder alias file or a symlink
  aliasFile,
}
