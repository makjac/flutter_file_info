package com.ecoala.flutter_file_info

import java.nio.file.attribute.PosixFilePermission
import java.util.Date

data class FileMetadata(
    val filePath: String,
    val fileName: String?,
    val fileExtension: String?,
    val fileType: String?,
    val creationTime: Date?,
    val modifiedTime: Date?,
    val accessedTime: Date?,
    val sizeBytes: Long?,
    val fileSize: String?,
    val attributes: Set<PosixFilePermission>?
)
