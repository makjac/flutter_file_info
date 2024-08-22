package com.ecoala.flutter_file_info

import java.nio.file.attribute.PosixFilePermission
import java.util.Date

/**
 * Represents metadata information about a file.
 *
 * @property filePath The path of the file.
 * @property fileName The name of the file.
 * @property fileExtension The extension of the file.
 * @property fileType The type of the file.
 * @property creationTime The creation time of the file.
 * @property modifiedTime The last modified time of the file.
 * @property accessedTime The last accessed time of the file.
 * @property sizeBytes The size of the file in bytes.
 * @property fileSize The size of the file as a human-readable string.
 * @property attributes The set of POSIX file permissions for the file.
 */
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
