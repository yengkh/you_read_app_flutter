import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReadPageFromDownload extends StatefulWidget {
  const ReadPageFromDownload({
    super.key,
    required this.name,
    required this.file,
  });
  final String name;
  final String file;

  @override
  State<ReadPageFromDownload> createState() => _ReadPageFromDownloadState();
}

class _ReadPageFromDownloadState extends State<ReadPageFromDownload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text(
          widget.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SfPdfViewer.file(File(widget.file)),
    );
  }
}
