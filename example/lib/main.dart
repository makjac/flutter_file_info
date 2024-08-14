import 'dart:typed_data';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Uint8List? _imageBytes;

  Future<String?> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return result.files.single.path!;
    } else {
      return null;
    }
  }

  Future<String?> _pickDirectory() async {
    return await FilePicker.platform.getDirectoryPath();
  }

  void _setupIcon(String path) async {
    final iconInfo = await FileInfo.instance.getFileIconInfo(path);

    if (iconInfo != null) {
      setState(() {
        _imageBytes = iconInfo.pixelData;
      });
    }
  }

  void _loadFile() async {
    final filePath = await _pickFile();
    if (filePath == null) return;
    _setupIcon(filePath);
  }

  void _loadDirectory() async {
    final fileDirectory = await _pickDirectory();
    if (fileDirectory == null) return;
    _setupIcon(fileDirectory);
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
            _imageBytes != null
                ? Image.memory(_imageBytes!)
                : const SizedBox.shrink(),
            _buildButtons(),
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
            onPressed: _loadFile,
            child: const Text("Load File"),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: _loadDirectory,
            child: const Text("Load Direcotry"),
          ),
        ],
      ),
    );
  }
}
