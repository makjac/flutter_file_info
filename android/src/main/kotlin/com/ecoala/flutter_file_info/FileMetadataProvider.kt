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

class FileMetadataProvider {
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
