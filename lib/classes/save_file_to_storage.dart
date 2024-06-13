import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:you_read_app_flutter/database/download_database_helper.dart';
import 'package:you_read_app_flutter/models/download_model.dart';

class DownloadService {
  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory directory;
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      directory = Directory("/storage/emulated/0/Download");
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final exPath = directory.path;
    if (kDebugMode) {
      print("Saved Path: $exPath");
    }
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> writeCounter(Uint8List bytes, String name) async {
    final path = await _localPath;
    // Create a file for the path of device and file name with extension
    File file = File('$path/$name');
    if (kDebugMode) {
      print("Save file");
    }

    // Write the data in the file you have created
    return file.writeAsBytes(bytes);
  }

  static Future<void> downloadFile({
    required String fileUrl,
    required String imageUrl,
    required String name,
    required String author,
    required String type,
    required String fileName,
    DownloadModel? downloadModel,
  }) async {
    // Send HTTP GET request to download the file
    final fileResponse = await http.get(Uri.parse(fileUrl));
    final imageResponse = await http.get(Uri.parse(imageUrl));

    if (fileResponse.statusCode == 200 && imageResponse.statusCode == 200) {
      // Write the file
      File file = await writeCounter(fileResponse.bodyBytes, fileName);

      // Write the image
      File imageFile = await writeCounter(imageResponse.bodyBytes, '$fileName.jpg');

      final DownloadModel dmModel = DownloadModel(
        name: name,
        author: author,
        type: type,
        file: file.path,
        image: imageFile.readAsBytesSync(),
      );

      if (downloadModel == null) {
        // Store the file path in the database
        await DownloadHelper.addToDownload(dmModel);
        if (kDebugMode) {
          print('File downloaded to: ${file.path}');
        }
      } else {
        await DownloadHelper.updateFromDownload(dmModel);
        if (kDebugMode) {
          print('File updated at: ${file.path}');
        }
      }
    } else {
      throw Exception('Failed to download file');
    }
  }
}
