package com.ecoala.flutter_file_info

import android.annotation.TargetApi
import android.os.Build
import java.io.File
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.attribute.BasicFileAttributes
import java.nio.file.attribute.PosixFilePermission
import java.text.DecimalFormat
import java.util.*

/**
 * This class is responsible for providing file metadata.
 */
class FileMetadataProvider {

    /**
     * Retrieves the metadata of a file specified by the given file path.
     *
     * @param filePath The path of the file.
     * @return The metadata of the file.
     */
    @TargetApi(Build.VERSION_CODES.O)
    fun getFileMetadata(filePath: String): FileMetadata {
        val file = File(filePath)
        val path = Paths.get(filePath)
        val attributes = Files.readAttributes(path, BasicFileAttributes::class.java)
        val posixAttributes: Set<PosixFilePermission> = try {
            Files.getPosixFilePermissions(path)
        } catch (e: UnsupportedOperationException) {
            emptySet()
        }

        val fileName = file.name
        val fileExtension = file.extension.takeIf { it.isNotEmpty() }
        val fileType = Files.probeContentType(path)
        val creationTime = Date(attributes.creationTime().toMillis())
        val modifiedTime = Date(attributes.lastModifiedTime().toMillis())
        val accessedTime = Date(attributes.lastAccessTime().toMillis())
        val sizeBytes = attributes.size()
        val fileSize = humanReadableByteCountSI(sizeBytes)

        return FileMetadata(
            filePath = filePath,
            fileName = fileName,
            fileExtension = fileExtension,
            fileType = fileType,
            creationTime = creationTime,
            modifiedTime = modifiedTime,
            accessedTime = accessedTime,
            sizeBytes = sizeBytes,
            fileSize = fileSize,
            attributes = posixAttributes
        )
    }

    /**
     * Converts the given [FileMetadata] object to a map representation.
     *
     * @param metadata The [FileMetadata] object to convert.
     * @return A map containing the metadata of the file.
     */
    fun fileMetadataToMap(metadata: FileMetadata): Map<String, Any?> {
        return mapOf(
            "filePath" to metadata.filePath,
            "fileName" to metadata.fileName,
            "fileExtension" to metadata.fileExtension,
            "fileType" to metadata.fileType,
            "creationTime" to metadata.creationTime?.time,
            "modifiedTime" to metadata.modifiedTime?.time,
            "accessedTime" to metadata.accessedTime?.time,
            "sizeBytes" to metadata.sizeBytes,
            "fileSize" to metadata.fileSize,
            "androidAttributes" to metadata.attributes?.map { it.name }
        )
    }
    private fun humanReadableByteCountSI(bytes: Long): String {
        val unit = 1000
        if (bytes < unit) return "$bytes B"
        val exp = (Math.log(bytes.toDouble()) / Math.log(unit.toDouble())).toInt()
        val pre = "kMGTPE"[exp - 1].toString()
        return DecimalFormat("#,##0.#").format(bytes / Math.pow(unit.toDouble(), exp.toDouble())) + " " + pre + "B"
    }
}
