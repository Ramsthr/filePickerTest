import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(FilePickerApp());
}

class FilePickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Picker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FilePickerHomePage(),
    );
  }
}

class FilePickerHomePage extends StatefulWidget {
  @override
  _FilePickerHomePageState createState() => _FilePickerHomePageState();
}

class _FilePickerHomePageState extends State<FilePickerHomePage> {
  String? _fileName;
  Uint8List? _fileBytes;
  File? _file;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      PlatformFile file = result.files.single;

      _fileName = file.name;
      _fileBytes = file.bytes;
      if (!kIsWeb) {
        _file = File(file.path!);
        _fileBytes = await _file!.readAsBytes();
      }

      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Picker App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Pick a file'),
            ),
            const SizedBox(height: 20),
            if (_fileName != null)
              Text(
                'File Name: $_fileName',
                style: const TextStyle(fontSize: 16),
              ),
            if (_fileBytes != null)
              const Text(
                'File Bytes Available',
                style: TextStyle(fontSize: 16),
              ),
            if (_fileBytes == null)
              const Text(
                'File Bytes not available',
                style: TextStyle(fontSize: 16),
              ),
            if (_file != null)
              Text(
                'File Path: $_file',
                style: const TextStyle(fontSize: 16),
              ),
            if (_fileBytes != null)
              Image.memory(
                _fileBytes!,
                fit: BoxFit.fill,
                width: 300,
                height: 300,
              ),
          ],
        ),
      ),
    );
  }
}
