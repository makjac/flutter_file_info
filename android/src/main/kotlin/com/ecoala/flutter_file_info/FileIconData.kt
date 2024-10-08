package com.ecoala.flutter_file_info

/**
 * Represents a class that provides file icon data.
 *
 * This class contains two properties: `fileIconMap` and `mimeCategoryIconMap`.
 * `fileIconMap` is a map that associates file extensions with their corresponding icon resource IDs.
 * `mimeCategoryIconMap` is a map that associates MIME categories with their corresponding icon resource IDs.
 */
class FileIconData {

    companion object {
        /**
         * Map of file extensions to corresponding file icons.
         *
         * This map associates file extensions with their respective file icons. Each key-value pair in the map represents an extension and its corresponding icon resource ID.
         *
         * Example usage:
         * ```
         * val fileIconMap: Map<String, Int> = mapOf(
         *     "adb" to R.drawable.ic_adb,
         *     "apk" to R.drawable.ic_apk,
         *     // ...
         *     "stc" to R.drawable.ic_spreadsheet
         * )
         * ```
         */
        val fileIconMap: Map<String, Int> = mapOf(
            "adb" to R.drawable.ic_adb,
            "apk" to R.drawable.ic_apk,
            "bin" to R.drawable.ic_binary,
            "deploy" to R.drawable.ic_binary,
            "msp" to R.drawable.ic_binary,
            "msu" to R.drawable.ic_binary,
            "icz" to R.drawable.ic_calendar,
            "ics" to R.drawable.ic_calendar,
            "vcs" to R.drawable.ic_calendar,
            "java" to R.drawable.ic_code,
            "py" to R.drawable.ic_code,
            "cpp" to R.drawable.ic_code,
            "xml" to R.drawable.ic_code,
            "csh" to R.drawable.ic_code,
            "tcl" to R.drawable.ic_code,
            "h++" to R.drawable.ic_code,
            "hpp" to R.drawable.ic_code,
            "hxx" to R.drawable.ic_code,
            "hh" to R.drawable.ic_code,
            "c++" to R.drawable.ic_code,
            "cxx" to R.drawable.ic_code,
            "cc" to R.drawable.ic_code,
            "h" to R.drawable.ic_code,
            "c" to R.drawable.ic_code,
            "d" to R.drawable.ic_code,
            "hs" to R.drawable.ic_code,
            "ihs" to R.drawable.ic_code,
            "p" to R.drawable.ic_code,
            "pas" to R.drawable.ic_code,
            "th" to R.drawable.ic_code,
            "tex" to R.drawable.ic_code,
            "ltx" to R.drawable.ic_code,
            "sty" to R.drawable.ic_code,
            "cls" to R.drawable.ic_code,
            "gtar" to R.drawable.ic_compress,
            "zip" to R.drawable.ic_compress,
            "xz" to R.drawable.ic_compress,
            "tar" to R.drawable.ic_compress,
            "rar" to R.drawable.ic_compress,
            "jar" to R.drawable.ic_compress,
            "gz" to R.drawable.ic_compress,
            "7z" to R.drawable.ic_compress,
            "vcard" to R.drawable.ic_contacts,
            "vcf" to R.drawable.ic_contacts,
            "crl" to R.drawable.ic_cryptography,
            "crt" to R.drawable.ic_cryptography,
            "key" to R.drawable.ic_cryptography,
            "p7r" to R.drawable.ic_cryptography,
            "pgp" to R.drawable.ic_cryptography,
            "sig" to R.drawable.ic_cryptography,
            "css" to R.drawable.ic_css,
            "css3" to R.drawable.ic_css,
            "sass" to R.drawable.ic_css,
            "less" to R.drawable.ic_css,
            "styl" to R.drawable.ic_css,
            "dart" to R.drawable.ic_dart,
            "sql" to R.drawable.ic_database,
            "sqlite" to R.drawable.ic_database,
            "sqlite3" to R.drawable.ic_database,
            "dbf" to R.drawable.ic_database,
            "mdb" to R.drawable.ic_database,
            "accdb" to R.drawable.ic_database,
            "bak" to R.drawable.ic_database,
            "dump" to R.drawable.ic_database,
            "doc" to R.drawable.ic_document,
            "dot" to R.drawable.ic_document,
            "odt" to R.drawable.ic_document,
            "odm" to R.drawable.ic_document,
            "ott" to R.drawable.ic_document,
            "oth" to R.drawable.ic_document,
            "docx" to R.drawable.ic_document,
            "dotx" to R.drawable.ic_document,
            "sdw" to R.drawable.ic_document,
            "sgl" to R.drawable.ic_document,
            "sxw" to R.drawable.ic_document,
            "sxg" to R.drawable.ic_document,
            "stw" to R.drawable.ic_document,
            "exe" to R.drawable.ic_exe,
            "gsf" to R.drawable.ic_font,
            "pfa" to R.drawable.ic_font,
            "pfb" to R.drawable.ic_font,
            "ttf" to R.drawable.ic_font,
            "otf" to R.drawable.ic_font,
            "woff" to R.drawable.ic_font,
            "woff2" to R.drawable.ic_font,
            "eot" to R.drawable.ic_font,
            "afm" to R.drawable.ic_font,
            "suit" to R.drawable.ic_font,
            "dfont" to R.drawable.ic_font,
            "html" to R.drawable.ic_html,
            "xhtml" to R.drawable.ic_html,
            "xhtm" to R.drawable.ic_html,
            "xht" to R.drawable.ic_html,
            "htm" to R.drawable.ic_html,
            "shtml" to R.drawable.ic_html,
            "iso" to R.drawable.ic_iso,
            "js" to R.drawable.ic_java_script,
            "mjs" to R.drawable.ic_java_script,
            "cjs" to R.drawable.ic_java_script,
            "js.map" to R.drawable.ic_java_script,
            "jsc" to R.drawable.ic_java_script,
            "json" to R.drawable.ic_json,
            "json5" to R.drawable.ic_json,
            "geojson" to R.drawable.ic_json,
            "cson" to R.drawable.ic_json,
            "jsonc" to R.drawable.ic_json,
            "yml" to R.drawable.ic_json,
            "yaml" to R.drawable.ic_json,
            "toml" to R.drawable.ic_json,
            "pdf" to R.drawable.ic_pdf,
            "php" to R.drawable.ic_php,
            "php5" to R.drawable.ic_php,
            "php7" to R.drawable.ic_php,
            "php8" to R.drawable.ic_php,
            "phtml" to R.drawable.ic_php,
            "phar" to R.drawable.ic_php,
            "raw" to R.drawable.ic_raw,
            "cr2" to R.drawable.ic_raw,
            "nef" to R.drawable.ic_raw,
            "arw" to R.drawable.ic_raw,
            "dng" to R.drawable.ic_raw,
            "pot" to R.drawable.ic_slide,
            "sti" to R.drawable.ic_slide,
            "sxi" to R.drawable.ic_slide,
            "sdd" to R.drawable.ic_slide,
            "potx" to R.drawable.ic_slide,
            "ppsx" to R.drawable.ic_slide,
            "pptx" to R.drawable.ic_slide,
            "odp" to R.drawable.ic_slide,
            "pps" to R.drawable.ic_slide,
            "ppt" to R.drawable.ic_slide,
            "xls" to R.drawable.ic_spreadsheet,
            "xlb" to R.drawable.ic_spreadsheet,
            "xlt" to R.drawable.ic_spreadsheet,
            "ods" to R.drawable.ic_spreadsheet,
            "xlsx" to R.drawable.ic_spreadsheet,
            "xltx" to R.drawable.ic_spreadsheet,
            "sdc" to R.drawable.ic_spreadsheet,
            "sxc" to R.drawable.ic_spreadsheet,
            "stc" to R.drawable.ic_spreadsheet
        )

        /**
         * Map that associates mime categories with corresponding icon resources.
         *
         * The keys of the map represent mime categories, while the values represent the corresponding icon resources.
         * The mime categories include "audio", "video", "text", "message", "image", "inode", and "font".
         *
         * @property mimeCategoryIconMap The map that associates mime categories with corresponding icon resources.
         */
        val mimeCategoryIconMap: Map<String, Int> = mapOf(
            "audio" to R.drawable.ic_audio_file,
            "video" to R.drawable.ic_video_file,
            "text" to R.drawable.ic_text_file,
            "message" to R.drawable.ic_message,
            "image" to R.drawable.ic_image,
            "inode" to R.drawable.ic_inode,
            "font" to R.drawable.ic_font
        )
    }
}