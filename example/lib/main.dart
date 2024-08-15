import 'package:example/file_icon.dart';
import 'package:example/file_metadata_table.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_info/flutter_file_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_file_info Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo flutter_file_info'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IconInfo? _iconInfo;
  FileMetadata? _fileMetadata;

  Future<void> _loadFileData({bool isDirectory = false}) async {
    final path = isDirectory
        ? await FilePicker.platform.getDirectoryPath()
        : await _pickFile();
    if (path == null) return;

    final iconInfo = await FileInfo.instance.getFileIconInfo(path);
    final metadata = await FileInfo.instance.getFileInfo(path);

    setState(() {
      _iconInfo = iconInfo;
      _fileMetadata = metadata;
    });
  }

  Future<String?> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    return result?.files.single.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButtons(),
            FileIcon(iconInfo: _iconInfo),
            FileMetadataTable(fileMetadata: _fileMetadata),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _loadFileData(isDirectory: false),
            child: const Text("Load File"),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () => _loadFileData(isDirectory: true),
            child: const Text("Load Directory"),
          ),
        ],
      ),
    );
  }
}
