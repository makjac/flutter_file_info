import Flutter
import MobileCoreServices
import UIKit
import UniformTypeIdentifiers

public class FlutterFileInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "flutter_file_info", binaryMessenger: registrar.messenger())
    let instance = FlutterFileInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getFileIcon":
      handleGetIcon(call, result: result)
    case "getFileInfo":
      handleGetMetadata(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func handleGetIcon(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
      let path = args["filePath"] as? String
    else {
      result(
        FlutterError(
          code: "INVALID_ARGS",
          message: "Missing or invalid file path",
          details: nil
        ))
      return
    }

    generateIconData(path: path, result: result)
  }

  private func generateIconData(path: String, result: @escaping FlutterResult) {
    let fileURL = URL(fileURLWithPath: path)

    guard let iconImage = UIImage.icon(forFileURL: fileURL, preferredSize: .largest) else {
      result(
        FlutterError(
          code: "ICON_GENERATION_ERROR",
          message: "Failed to generate system icon",
          details: nil
        ))
      return
    }

    prepareResponseData(image: iconImage, result: result)
  }

  private func prepareResponseData(image: UIImage, result: @escaping FlutterResult) {
    let renderedImage = image.withRenderingMode(.alwaysOriginal)

    guard let pngData = renderedImage.pngData() else {
      result(
        FlutterError(
          code: "IMAGE_CONVERSION_ERROR",
          message: "Failed to convert image to PNG",
          details: nil
        ))
      return
    }

    let response: [String: Any] = [
      "pixelData": FlutterStandardTypedData(bytes: pngData),
      "width": Int(image.size.width * image.scale),
      "height": Int(image.size.height * image.scale),
    ]

    result(response)
  }

  private func handleGetMetadata(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
      let filePath = args["filePath"] as? String
    else {
      result(
        FlutterError(
          code: "INVALID_ARGS",
          message: "Missing or invalid file path",
          details: nil
        ))
      return
    }

    let fileURL = URL(fileURLWithPath: filePath)
    let fileManager = FileManager.default

    guard fileManager.fileExists(atPath: filePath) else {
      result(
        FlutterError(
          code: "FILE_NOT_FOUND",
          message: "File does not exist",
          details: nil
        ))
      return
    }

    do {
      let attributes = try fileManager.attributesOfItem(atPath: filePath)
      let resourceValues = try fileURL.resourceValues(forKeys: [
        .nameKey,
        .localizedNameKey,
        .pathKey,
        .creationDateKey,
        .contentModificationDateKey,
        .contentAccessDateKey,
        .fileSizeKey,
        .typeIdentifierKey,
        .isApplicationKey,
        .isPackageKey,
        .isHiddenKey,
        .isReadableKey,
        .isWritableKey,
        .isSystemImmutableKey,
        .isUserImmutableKey,
        .isExcludedFromBackupKey,
        .isDirectoryKey,
        .isRegularFileKey,
        .isSymbolicLinkKey,
        .isMountTriggerKey,
        .isVolumeKey,
        .isAliasFileKey,
      ])

      let metadata: [String: Any?] = [
        "filePath": filePath,
        "fileName": resourceValues.name,
        "fileExtension": fileURL.pathExtension,
        "fileType": resourceValues.typeIdentifier,
        "creationTime": resourceValues.creationDate.map { Int($0.timeIntervalSince1970 * 1000) },
        "modifiedTime": resourceValues.contentModificationDate.map {
          Int($0.timeIntervalSince1970 * 1000)
        },
        "accessedTime": resourceValues.contentAccessDate.map {
          Int($0.timeIntervalSince1970 * 1000)
        },
        "sizeBytes": resourceValues.fileSize,
        "fileSize": formatFileSize(resourceValues.fileSize ?? 0),
        "iOSAttributes": getIOSAttributes(resourceValues: resourceValues),
      ]

      result(metadata)
    } catch {
      result(
        FlutterError(
          code: "METADATA_ERROR",
          message: "Failed to retrieve file metadata: \(error.localizedDescription)",
          details: nil
        ))
    }
  }

  private func formatFileSize(_ sizeBytes: Int) -> String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
    formatter.countStyle = .file
    return formatter.string(fromByteCount: Int64(sizeBytes))
  }

  private func getIOSAttributes(resourceValues: URLResourceValues) -> [String] {
    var attributes: [String] = []

    if resourceValues.isApplication == true { attributes.append("application") }
    if resourceValues.isPackage == true { attributes.append("package") }
    if resourceValues.isHidden == true { attributes.append("hidden") }
    if resourceValues.isReadable == true { attributes.append("readable") }
    if resourceValues.isWritable == true { attributes.append("writable") }
    if resourceValues.isSystemImmutable == true { attributes.append("systemImmutable") }
    if resourceValues.isUserImmutable == true { attributes.append("userImmutable") }
    if resourceValues.isExcludedFromBackup == true { attributes.append("excludedFromBackup") }
    if resourceValues.isDirectory == true { attributes.append("directory") }
    if resourceValues.isRegularFile == true { attributes.append("regularFile") }
    if resourceValues.isSymbolicLink == true { attributes.append("symbolicLink") }
    if resourceValues.isMountTrigger == true { attributes.append("mountTrigger") }
    if resourceValues.isVolume == true { attributes.append("volume") }
    if resourceValues.isAliasFile == true { attributes.append("aliasFile") }

    return attributes
  }
}

extension UIImage {
  public enum FileIconSize {
    case smallest
    case largest
  }

  public class func icon(forFileURL fileURL: URL, preferredSize: FileIconSize = .smallest)
    -> UIImage?
  {
    let myInteractionController = UIDocumentInteractionController(url: fileURL)
    let allIcons = myInteractionController.icons

    switch preferredSize {
    case .smallest: return allIcons.first!
    case .largest: return allIcons.last!
    }
  }
}
