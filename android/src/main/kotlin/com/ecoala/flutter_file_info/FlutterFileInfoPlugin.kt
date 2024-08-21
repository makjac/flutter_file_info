package com.ecoala.flutter_file_info

import com.ecoala.flutter_file_info.FileIconProvider


import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.util.Base64

/**
 * FlutterFileInfoPlugin class is responsible for handling method calls from Flutter and implementing the FlutterPlugin interface.
 */
class FlutterFileInfoPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var fileIconProvider: FileIconProvider

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_file_info")
    channel.setMethodCallHandler(this)

    fileIconProvider = FileIconProvider(flutterPluginBinding.applicationContext, flutterPluginBinding.applicationContext.packageManager)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getFileIcon") {
      val filePath = call.argument<String>("filePath")
      if (filePath != null) {
        handleGetFileIcon(filePath, result)
      } else {
        result.error("INVALID_ARGUMENT", "File path is required", null)
      }
    } else {
      result.notImplemented()
    }
  }

  /**
   * Handles the retrieval of a file icon for the specified file path.
   *
   * @param filePath The path of the file for which to retrieve the icon.
   * @param result The result object used to communicate the icon data back to the caller.
   */
  private fun handleGetFileIcon(filePath: String, result: Result) {
    val drawable = fileIconProvider.getFileIcon(filePath)
    if (drawable != null) {
      val (pixelData, width, height) = fileIconProvider.convertDrawableToPixelData(drawable)
      val encodedImage = Base64.encodeToString(pixelData, Base64.DEFAULT)

      val iconData = mapOf(
              "pixelData" to encodedImage,
              "width" to width,
              "height" to height
      )
      result.success(iconData)
    } else {
      result.error("FILE_NOT_FOUND", "Icon not found for the specified file", null)
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
