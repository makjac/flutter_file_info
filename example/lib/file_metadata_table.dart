import 'package:flutter/material.dart';
import 'package:flutter_file_info/flutter_file_info.dart';

class FileMetadataTable extends StatelessWidget {
  const FileMetadataTable({super.key, this.fileMetadata});

  final FileMetadata? fileMetadata;

  TableRow _buildRow(String label, String? value, {bool isHeader = false}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? const Color(0xFFE0E0E0) : null,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value ?? ''),
        ),
      ],
    );
  }

  String? _formatAttributes(FileMetadata? mtadata, TargetPlatform platform) {
    if (platform == TargetPlatform.windows) {
      return mtadata?.winAttributes?.map((e) => e.name).join(', ');
    } else if (platform == TargetPlatform.android) {
      return mtadata?.androidAttributes?.map((e) => e.name).join(', ');
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        border: TableBorder.all(),
        children: [
          _buildRow('File Path', fileMetadata?.filePath, isHeader: true),
          _buildRow('File Name', fileMetadata?.fileName),
          _buildRow('File Extension', fileMetadata?.fileExtension,
              isHeader: true),
          _buildRow('File Type', fileMetadata?.fileType),
          _buildRow('Creation Time', fileMetadata?.creationTime?.toString(),
              isHeader: true),
          _buildRow('Modified Time', fileMetadata?.modifiedTime?.toString()),
          _buildRow('Accessed Time', fileMetadata?.accessedTime?.toString(),
              isHeader: true),
          _buildRow('Size (Bytes)', fileMetadata?.sizeBytes?.toString()),
          _buildRow('File Size', fileMetadata?.fileSize, isHeader: true),
          _buildRow(
            "Attributes",
            _formatAttributes(fileMetadata, platform),
          ),
        ],
      ),
    );
  }
}
