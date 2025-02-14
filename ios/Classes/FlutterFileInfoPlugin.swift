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

    guard let uti = getFileUTI(fileURL: fileURL) else {
      result(
        FlutterError(
          code: "FILE_TYPE_ERROR",
          message: "Could not determine file type",
          details: nil
        ))
      return
    }

    guard let iconImage = getSystemIcon(uti: uti) else {
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

  private func getFileUTI(fileURL: URL) -> String? {
    if #available(iOS 14.0, *) {
      return try? fileURL.resourceValues(forKeys: [.contentTypeKey])
        .contentType?
        .identifier
    } else {
      let ext = fileURL.pathExtension as CFString
      return UTTypeCreatePreferredIdentifierForTag(
        kUTTagClassFilenameExtension,
        ext,
        nil
      )?.takeRetainedValue() as String?
    }
  }

  private func getSystemIcon(uti: String) -> UIImage? {

    guard
      let fileExtension = UTTypeCopyPreferredTagWithClass(
        uti as CFString,
        kUTTagClassFilenameExtension
      )?.takeRetainedValue() as String?
    else {
      return UIImage(systemName: "doc")
    }

    let dummyURL = URL(fileURLWithPath: "file.\(fileExtension)")
    let controller = UIDocumentInteractionController(url: dummyURL)

    return controller.icons.last ?? UIImage(systemName: "doc")
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
}
