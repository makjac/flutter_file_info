import AppKit
import FlutterMacOS
import UniformTypeIdentifiers

public class FlutterFileInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "flutter_file_info", binaryMessenger: registrar.messenger)
    let instance = FlutterFileInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getFileIcon" {
      guard let args = call.arguments as? [String: Any],
        let path = args["filePath"] as? String
      else {
        result(FlutterError(code: "INVALID_ARGS", message: "Brak ścieżki pliku", details: nil))
        return
      }

      let url = URL(fileURLWithPath: path)
      let icon = NSWorkspace.shared.icon(forFile: url.path)

      let newSize = NSSize(width: 128, height: 128)
      let resizedIcon = self.resize(image: icon, to: newSize)

      guard let tiffData = resizedIcon.tiffRepresentation,
        let bitmapImage = NSBitmapImageRep(data: tiffData),
        let pngData = bitmapImage.representation(using: .png, properties: [:])
      else {
        result(
          FlutterError(code: "CONVERSION_ERROR", message: "Błąd konwersji ikony", details: nil))
        return
      }

      let response: [String: Any] = [
        "pixelData": FlutterStandardTypedData(bytes: pngData),
        "width": Int(newSize.width),
        "height": Int(newSize.height),
      ]

      result(response)
    } else if call.method == "getFileInfo" {
      self.handleGetFileMetadata(call, result: result)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func resize(image: NSImage, to newSize: NSSize) -> NSImage {
    let newImage = NSImage(size: newSize)
    newImage.lockFocus()
    image.draw(in: NSRect(origin: .zero, size: newSize))
    newImage.unlockFocus()
    return newImage
  }

  private func handleGetFileMetadata(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
      let path = args["filePath"] as? String
    else {
      result(FlutterError(code: "INVALID_ARGS", message: "Brak ścieżki pliku", details: nil))
      return
    }

    let url = URL(fileURLWithPath: path)
    var attributes: [String: Any] = [:]
    var macosAttributes: [String] = []

    do {

      let fileManager = FileManager.default
      let fileAttributes = try fileManager.attributesOfItem(atPath: path)

      attributes["fileName"] = url.lastPathComponent
      attributes["fileExtension"] = url.pathExtension

      attributes["creationTime"] =
        (fileAttributes[.creationDate] as? Date)?.timeIntervalSince1970.milliseconds
      attributes["modifiedTime"] =
        (fileAttributes[.modificationDate] as? Date)?.timeIntervalSince1970.milliseconds

      let sizeBytes = fileAttributes[.size] as? Int
      attributes["sizeBytes"] = sizeBytes

      if let bytes = sizeBytes {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useAll]
        formatter.countStyle = .file
        attributes["fileSize"] = formatter.string(fromByteCount: Int64(bytes))
      }

      if let uti = UTTypeCreatePreferredIdentifierForTag(
        kUTTagClassFilenameExtension,
        url.pathExtension as CFString,
        nil
      )?.takeRetainedValue() {
        attributes["fileType"] = UTTypeCopyDescription(uti)?.takeRetainedValue() as String?
      }

      let resourceValues = try url.resourceValues(forKeys: [
        .isHiddenKey,
        .isDirectoryKey,
        .isRegularFileKey,
        .isSymbolicLinkKey,
        .isVolumeKey,
        .isPackageKey,
        .isApplicationKey,
      ])

      if resourceValues.isHidden == true { macosAttributes.append("hidden") }
      if resourceValues.isDirectory == true { macosAttributes.append("directory") }
      if resourceValues.isRegularFile == true { macosAttributes.append("regularFile") }
      if resourceValues.isSymbolicLink == true { macosAttributes.append("symbolicLink") }
      if resourceValues.isVolume == true { macosAttributes.append("volume") }
      if resourceValues.isPackage == true { macosAttributes.append("package") }
      if resourceValues.isApplication == true { macosAttributes.append("application") }

      if let posixPermissions = fileAttributes[.posixPermissions] as? Int {
        if posixPermissions & 0o200 == 0 { macosAttributes.append("readOnly") }
        if posixPermissions & 0o100 != 0 { macosAttributes.append("executable") }
      }

    } catch {
      result(FlutterError(code: "FILE_ERROR", message: error.localizedDescription, details: nil))
      return
    }

    attributes["filePath"] = path
    attributes["macosAttributes"] = macosAttributes

    result(attributes)
  }
}

extension TimeInterval {
  var milliseconds: Int {
    return Int(self * 1000)
  }
}
