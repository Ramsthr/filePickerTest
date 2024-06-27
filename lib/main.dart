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
  String? _filePath;

  Future<void> _pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _filePath = result.files.single.path;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick a file'),
            ),
            SizedBox(height: 20),
            if (_fileName != null)
              Text(
                'File Name: $_fileName',
                style: TextStyle(fontSize: 16),
              ),
            if (_filePath != null)
              Text(
                'File Path: $_filePath',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
