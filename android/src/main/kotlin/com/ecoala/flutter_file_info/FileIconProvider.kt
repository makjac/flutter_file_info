package com.ecoala.flutter_file_info

import android.content.Context
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.graphics.pdf.PdfRenderer
import android.os.ParcelFileDescriptor
import android.webkit.MimeTypeMap
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.IOException

class FileIconProvider(private val context: Context, private val packageManager: PackageManager) {
    private fun isFolder(filePath: String): Boolean {
        val file = File(filePath)
        return file.isDirectory
    }
    private fun getFolderIcon(): Drawable? {
        val drawable: Drawable? = context.getDrawable(R.drawable.ic_folder)
        return if (drawable is BitmapDrawable) {
            drawable
        } else {
            drawable?.let {
                val bitmap = Bitmap.createBitmap(
                        it.intrinsicWidth,
                        it.intrinsicHeight,
                        Bitmap.Config.ARGB_8888
                )
                val canvas = Canvas(bitmap)
                it.setBounds(0, 0, canvas.width, canvas.height)
                it.draw(canvas)
                BitmapDrawable(context.resources, bitmap)
            }
        }
    }
    private fun getFileMimeIcon(filePath: String): Int? {
        val extension = filePath.substringAfterLast('.', "").lowercase()
        return FileIconData.fileIconMap[extension]
    }
    fun convertDrawableToPixelData(drawable: Drawable): Triple<ByteArray, Double, Double> {
        val bitmap = convertDrawableToBitmap(drawable)
        val pixelData = bitmapToByteArray(bitmap)
        val width = bitmap.width.toDouble()
        val height = bitmap.height.toDouble()
        return Triple(pixelData, width, height)
    }
    private fun convertDrawableToBitmap(drawable: Drawable): Bitmap {
        return if (drawable is BitmapDrawable) {
            drawable.bitmap
        } else {
            val bitmap = Bitmap.createBitmap(
                    drawable.intrinsicWidth.takeIf { it > 0 } ?: 100,
                    drawable.intrinsicHeight.takeIf { it > 0 } ?: 100,
                    Bitmap.Config.ARGB_8888
            )
            val canvas = Canvas(bitmap)
            drawable.setBounds(0, 0, canvas.width, canvas.height)
            drawable.draw(canvas)
            bitmap
        }
    }
    private fun bitmapToByteArray(bitmap: Bitmap): ByteArray {
        val stream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
        return stream.toByteArray()
    }
    private fun getDefaultIcon(): Drawable? {
        return context.getDrawable(R.drawable.ic_default_file)
    }
    private fun String.isImageFile(): Boolean {
        val imageExtensions = listOf("jpg", "jpeg", "png", "gif", "bmp", "webp")
        return imageExtensions.any { this.endsWith(it, ignoreCase = true) }
    }
}
