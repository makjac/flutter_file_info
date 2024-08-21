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
    private fun getCategoryIcon(filePath: String): Int? {
        val mimeType = getMimeType(filePath)
        mimeType?.let {
            val category = it.substringBefore('/')
            return FileIconData.mimeCategoryIconMap[category]
        }
        return null
    }
    private fun generateImagePreviewAsDrawable(imagePath: String): Drawable? {
        val previewBitmap = generateImagePreview(imagePath)
        return previewBitmap?.let { BitmapDrawable(context.resources, it) }
    }
    private fun generatePdfPreviewAsDrawable(pdfPath: String): Drawable? {
        val previewBitmap = generatePdfPreview(pdfPath)
        return previewBitmap?.let { BitmapDrawable(context.resources, it) }
    }
    private fun generateImagePreview(imagePath: String): Bitmap? {
        val originalBitmap = BitmapFactory.decodeFile(imagePath) ?: return null

        val maxPreviewWidth = 200
        val maxPreviewHeight = 200

        val originalWidth = originalBitmap.width
        val originalHeight = originalBitmap.height

        val scale = Math.min(
                maxPreviewWidth.toFloat() / originalWidth,
                maxPreviewHeight.toFloat() / originalHeight
        )

        val previewWidth = (originalWidth * scale).toInt()
        val previewHeight = (originalHeight * scale).toInt()

        return Bitmap.createScaledBitmap(originalBitmap, previewWidth, previewHeight, true)
    }
    private fun generatePdfPreview(pdfPath: String): Bitmap? {
        var fileDescriptor: ParcelFileDescriptor? = null
        var pdfRenderer: PdfRenderer? = null
        try {
            fileDescriptor = ParcelFileDescriptor.open(File(pdfPath), ParcelFileDescriptor.MODE_READ_ONLY)
            pdfRenderer = PdfRenderer(fileDescriptor)

            if (pdfRenderer.pageCount < 1) {
                return null
            }

            val page = pdfRenderer.openPage(0)

            val bitmap = Bitmap.createBitmap(page.width, page.height, Bitmap.Config.ARGB_8888)

            page.render(bitmap, null, null, PdfRenderer.Page.RENDER_MODE_FOR_DISPLAY)

            page.close()
            return bitmap
        } catch (e: IOException) {
            e.printStackTrace()
            return null
        } finally {
            pdfRenderer?.close()
            fileDescriptor?.close()
        }
    }
    private fun getMimeType(filePath: String): String? {
        val extension = MimeTypeMap.getFileExtensionFromUrl(filePath)
        return MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension)
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
