import 'package:flutter/material.dart';
import 'package:flutter_file_info/flutter_file_info.dart';

class FileIcon extends StatelessWidget {
  const FileIcon({super.key, this.iconInfo});

  final IconInfo? iconInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      child: iconInfo == null
          ? const Icon(Icons.question_mark)
          : Image.memory(
              iconInfo!.pixelData,
              width: iconInfo!.width.toDouble(),
              height: iconInfo!.height.toDouble(),
            ),
    );
  }
}
