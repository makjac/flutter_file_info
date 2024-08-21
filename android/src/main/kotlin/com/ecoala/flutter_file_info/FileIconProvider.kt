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

    /**
     * Retrieves the icon for a file based on its file path.
     *
     * @param filePath The path of the file.
     * @return The drawable representing the file icon, or null if the icon is not found.
     */
    fun getFileIcon(filePath: String): Drawable? {
        if (isFolder(filePath)) {
            return getFolderIcon()
        }

        val apkIcon = if (filePath.endsWith(".apk")) getApkIcon(filePath) else null
        if (apkIcon != null) return apkIcon

        val imageIcon = if (filePath.isImageFile()) generateImagePreviewAsDrawable(filePath) else null
        if (imageIcon != null) return imageIcon

        val pdfIcon = if (filePath.endsWith(".pdf")) generatePdfPreviewAsDrawable(filePath) else null
        if (pdfIcon != null) return pdfIcon

        val fileMimeIcon = getFileMimeIcon(filePath)?.let { context.getDrawable(it) }
        if (fileMimeIcon != null) return fileMimeIcon

        val categoryIcon = getCategoryIcon(filePath)?.let { context.getDrawable(it) }
        if (categoryIcon != null) return categoryIcon

        return getDefaultIcon()
    }

    /**
     * Determines whether the given file path represents a folder.
     *
     * @param filePath The file path to check.
     * @return `true` if the file path represents a folder, `false` otherwise.
     */
    private fun isFolder(filePath: String): Boolean {
        val file = File(filePath)
        return file.isDirectory
    }

    /**
     * Retrieves the folder icon.
     *
     * @return The drawable representing the folder icon, or null if it cannot be retrieved.
     */
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

    /**
     * Retrieves the icon for an APK file.
     *
     * @param apkFilePath The path of the APK file.
     * @return The icon of the APK file as a Drawable object, or null if the icon cannot be retrieved.
     */
    fun getApkIcon(apkFilePath: String): Drawable? {
        val packageInfo = packageManager.getPackageArchiveInfo(apkFilePath, PackageManager.GET_META_DATA)
        packageInfo?.applicationInfo?.apply {
            sourceDir = apkFilePath
            publicSourceDir = apkFilePath
            return loadIcon(packageManager)
        }
        return null
    }

    /**
     * Retrieves the icon associated with the file mime type of the given file path.
     *
     * @param filePath The path of the file.
     * @return The resource ID of the file mime icon, or null if no icon is found.
     */
    private fun getFileMimeIcon(filePath: String): Int? {
        val extension = filePath.substringAfterLast('.', "").lowercase()
        return FileIconData.fileIconMap[extension]
    }

    /**
     * Retrieves the category icon for the given file path.
     *
     * @param filePath The path of the file.
     * @return The category icon for the file, or null if no icon is found.
     */
    private fun getCategoryIcon(filePath: String): Int? {
        val mimeType = getMimeType(filePath)
        mimeType?.let {
            val category = it.substringBefore('/')
            return FileIconData.mimeCategoryIconMap[category]
        }
        return null
    }

    /**
     * Generates a drawable image preview for the given image path.
     *
     * @param imagePath The path of the image.
     * @return The generated drawable image preview, or null if the image path is invalid.
     */
    private fun generateImagePreviewAsDrawable(imagePath: String): Drawable? {
        val previewBitmap = generateImagePreview(imagePath)
        return previewBitmap?.let { BitmapDrawable(context.resources, it) }
    }

    /**
     * Generates a drawable preview of a PDF file.
     *
     * @param pdfPath The path of the PDF file.
     * @return The generated drawable preview of the PDF file, or null if the preview could not be generated.
     */
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
