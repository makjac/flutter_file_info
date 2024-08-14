#include "include/flutter_file_info/flutter_file_info_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_file_info_plugin.h"

void FlutterFileInfoPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_file_info::FlutterFileInfoPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
