#ifndef FLUTTER_PLUGIN_FLUTTER_FILE_INFO_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_FILE_INFO_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_file_info {

class FlutterFileInfoPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterFileInfoPlugin();

  virtual ~FlutterFileInfoPlugin();

  // Disallow copy and assign.
  FlutterFileInfoPlugin(const FlutterFileInfoPlugin&) = delete;
  FlutterFileInfoPlugin& operator=(const FlutterFileInfoPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_file_info

#endif  // FLUTTER_PLUGIN_FLUTTER_FILE_INFO_PLUGIN_H_
