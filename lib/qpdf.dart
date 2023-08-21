import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class QPDFScreen extends StatefulWidget {
  @override
  _QPDFScreenState createState() => _QPDFScreenState();
}

class _QPDFScreenState extends State<QPDFScreen> {
  String _selectedFileName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Conversion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Request permission to access external storage
                var status = await Permission.storage.request();
                if (status.isGranted) {
                  // Permission granted, open the file picker
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      _selectedFileName = result.files.single.name;
                    });
                  }
                } else {
                  // Permission denied
                  print('Permission denied for accessing external storage.');
                }
              },
              child: Text('Select a File'),
            ),
            SizedBox(height: 20),
            Text('Selected File: $_selectedFileName'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement PDF conversion logic
              },
              child: Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}
