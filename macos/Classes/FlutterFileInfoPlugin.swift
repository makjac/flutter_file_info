import AppKit
import FlutterMacOS

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

      let newSize = NSSize(width: 256, height: 256)
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
        "width": Int(icon.size.width),
        "height": Int(icon.size.height),
      ]

      result(response)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}
