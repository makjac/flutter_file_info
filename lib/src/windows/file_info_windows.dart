import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter_file_info/flutter_file_info.dart';
import 'package:flutter_file_info/src/windows/file_info_windows_ffi_types.dart';
import 'package:win32/win32.dart';
import 'package:image/image.dart' as img;

class FileInfoWindows extends FileInfo {
  FileInfoWindows({FileInfoWindowsFfiTypes? iconExtractor})
      : _iconExtractor = iconExtractor ?? FileInfoWindowsFfiTypesImpl();

  final FileInfoWindowsFfiTypes _iconExtractor;

  static void registerWith() {
    FileInfo.instance = FileInfoWindows();
  }

  @override
  Future<IconInfo?> getFileIconInfo(String filePath) async {
    final Pointer<SHFILEINFO> fileInfo = calloc<SHFILEINFO>();

    try {
      // Retrieve file icon information
      final fileInfoPtr = await _getFileIconInfo(filePath);
      final hIcon = fileInfoPtr.ref.hIcon;

      // Retrieve detailed icon information
      final piconinfo = await _getIconInfo(hIcon);

      // Retrieve bitmap information
      final pBitmapInfo = await _getBitmapInfo(piconinfo.ref.hbmColor);

      // Retrieve pixel data
      final pixelData =
          await _getPixelData(piconinfo.ref.hbmColor, pBitmapInfo);

      // Convert pixel data to PNG format
      final pngData = _convertToPng(
        pBitmapInfo.ref.bmiHeader.biWidth,
        pBitmapInfo.ref.bmiHeader.biHeight,
        pixelData,
      );

      return IconInfo(
        width: pBitmapInfo.ref.bmiHeader.biWidth,
        height: pBitmapInfo.ref.bmiHeader.biHeight,
        colorDepth: pBitmapInfo.ref.bmiHeader.biBitCount,
        pixelData: pngData,
      );
    } catch (e) {
      return null;
    } finally {
      calloc.free(fileInfo);
    }
  }

  Future<Pointer<SHFILEINFO>> _getFileIconInfo(String filePath) async {
    final Pointer<SHFILEINFO> fileInfo = calloc<SHFILEINFO>();

    try {
      _iconExtractor.shGetFileInfo(
        filePath.toNativeUtf16(),
        FILE_FLAGS_AND_ATTRIBUTES.FILE_ATTRIBUTE_DIRECTORY,
        fileInfo,
        sizeOf<SHFILEINFO>(),
        SHGFI_FLAGS.SHGFI_ICON |
            SHGFI_FLAGS.SHGFI_SYSICONINDEX |
            SHGFI_FLAGS.SHGFI_SHELLICONSIZE |
            SHGFI_FLAGS.SHGFI_LARGEICON,
      );
      return fileInfo;
    } catch (e) {
      calloc.free(fileInfo);
      rethrow;
    }
  }

  Future<Pointer<ICONINFO>> _getIconInfo(int hIcon) async {
    final Pointer<ICONINFO> piconinfo = calloc<ICONINFO>();

    try {
      _iconExtractor.getIconInfo(hIcon, piconinfo);
      return piconinfo;
    } catch (e) {
      calloc.free(piconinfo);
      rethrow;
    }
  }

  Future<Pointer<BITMAPINFO>> _getBitmapInfo(int hbmColor) async {
    final Pointer<BITMAPINFO> pBitmapInfo = calloc<BITMAPINFO>();

    try {
      pBitmapInfo.ref.bmiHeader.biSize = sizeOf<BITMAPINFOHEADER>();
      final hdcScreen = _iconExtractor.getDC(NULL);
      _iconExtractor.getDIBits(
        hdcScreen,
        hbmColor,
        0,
        0,
        nullptr,
        pBitmapInfo,
        DIB_USAGE.DIB_RGB_COLORS,
      );
      return pBitmapInfo;
    } catch (e) {
      calloc.free(pBitmapInfo);
      rethrow;
    }
  }

  Future<Uint8List> _getPixelData(
      int hbmColor, Pointer<BITMAPINFO> pBitmapInfo) async {
    final int bitmapSize = pBitmapInfo.ref.bmiHeader.biSizeImage;
    final biHeight = pBitmapInfo.ref.bmiHeader.biHeight;
    final isTopDownDIB = biHeight < 0;
    final height = isTopDownDIB ? -biHeight : biHeight;
    final lpvBits = calloc<Uint8>(bitmapSize);

    try {
      final hdcScreen = _iconExtractor.getDC(NULL);
      _iconExtractor.getDIBits(
        hdcScreen,
        hbmColor,
        0,
        height,
        lpvBits,
        pBitmapInfo,
        DIB_USAGE.DIB_RGB_COLORS,
      );

      // Reverse the image if required
      final rowSize = pBitmapInfo.ref.bmiHeader.biWidth *
          (pBitmapInfo.ref.bmiHeader.biBitCount / 8).ceil();
      for (var i = 0; i < height ~/ 2; i++) {
        final startIdx = i * rowSize;
        final endIdx = (height - 1 - i) * rowSize;
        for (var j = 0; j < rowSize; j++) {
          final temp = lpvBits[startIdx + j];
          lpvBits[startIdx + j] = lpvBits[endIdx + j];
          lpvBits[endIdx + j] = temp;
        }
      }

      return Uint8List.fromList(lpvBits.asTypedList(bitmapSize));
    } finally {
      calloc.free(lpvBits);
    }
  }

  Uint8List _convertToPng(int width, int height, Uint8List pixelData) {
    // Create an img.Image from the raw pixel data
    final image = img.Image.fromBytes(
      width: width,
      height: height,
      bytes: pixelData.buffer,
      order: img.ChannelOrder.bgra,
    );

    // Encode the image to PNG format
    return Uint8List.fromList(img.encodePng(image));
  }
}
