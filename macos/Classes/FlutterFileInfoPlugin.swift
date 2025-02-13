import Cocoa
import FlutterMacOS
import AppKit

public class FlutterFileInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_file_info", binaryMessenger: registrar.messenger)
    let instance = FlutterFileInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getFileIcon" {
      guard let args = call.arguments as? [String: Any],
            let path = args["filePath"] as? String else {
        result(FlutterError(
          code: "INVALID_ARGS",
          message: "Brak ścieżki pliku",
          details: nil
        ))
        return
      }

      let url = URL(fileURLWithPath: path)

      let icon = NSWorkspace.shared.icon(forFile: url.path)

      if let imageData = icon.tiffRepresentation,
          let bitmapImage = NSBitmapImageRep(data: imageData),
          let pngData = bitmapImage.representation(using: .png, properties: [:]) {
        result(FlutterStandardTypedData(bytes: pngData))
      } else {
        result(FlutterError(
          code: "NO_ICON",
          message: "Nie udało się wygenerować ikony",
          details: nil
        ))
      }
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}

