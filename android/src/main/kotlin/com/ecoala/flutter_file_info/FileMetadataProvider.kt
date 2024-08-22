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
}
