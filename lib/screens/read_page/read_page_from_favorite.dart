import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:you_read_app_flutter/custome_widget/back_arrow.dart';
import 'package:you_read_app_flutter/database/download_database_helper.dart';
import 'package:you_read_app_flutter/models/add_to_favorite_model.dart';
import 'package:you_read_app_flutter/models/download_model.dart';
import 'package:you_read_app_flutter/models/favorite_model.dart';
import 'package:you_read_app_flutter/screens/read_page/read_page_infor.dart';
import 'package:you_read_app_flutter/screens/read_page/read_page_item.dart';
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class ReadPageFromFavorite extends StatefulWidget {
  const ReadPageFromFavorite({
    super.key,
    required this.id,
    required this.name,
    required this.author,
    required this.type,
    required this.desc,
    required this.file,
    required this.image,
    required this.downloaded,
    this.sqlModel,
    this.downloadModel,
  });

  final String id;
  final String name;
  final String author;
  final String type;
  final String desc;
  final String file;
  final String image;
  final String downloaded;
  final FavoriteModel? sqlModel;
  final DownloadModel? downloadModel;

  @override
  State<ReadPageFromFavorite> createState() => _ReadPageFromFavoriteState();
}

class _ReadPageFromFavoriteState extends State<ReadPageFromFavorite> {
  final String fileUrl = "";

  // Function to download file from the internet
  Future<void> downloadFile({String? fileUrl, String? imageUrl}) async {
    // Send HTTP GET request to download the file
    final fileResponse = await http.get(Uri.parse(fileUrl!));
    final imageRespone = await http.get(Uri.parse(imageUrl!));
    if (fileResponse.statusCode == 200 && imageRespone.statusCode == 200) {
      Uint8List imageBytes = imageRespone.bodyBytes;
      // Get the directory for the user's downloads
      final directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/${widget.file}';

      // Write the file
      File file = File(filePath);
      await file.writeAsBytes(fileResponse.bodyBytes);

      final DownloadModel dmModel = DownloadModel(
        name: widget.name,
        author: widget.author,
        type: widget.type,
        file: filePath,
        image: imageBytes,
      );

      if (widget.downloadModel == null) {
        // Store the file bytes in the database
        await DownloadHelper.addToDownload(dmModel);
        if (kDebugMode) {
          print('File downloaded to: $filePath');
        }
      } else {
        await DownloadHelper.updateFromDownload(dmModel);
        if (kDebugMode) {
          print('File downloaded to: $filePath');
        }
      }
    } else {
      throw Exception('Failed to download file');
    }
  }

  Future<String> getCustomAppDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    return path.join(appDir.path, 'reader_app', 'app_flutter');
  }

  AddToFavoriteModel toBook() {
    return AddToFavoriteModel(
      id: widget.id,
      name: widget.name,
      author: widget.author,
      type: widget.type,
      desc: widget.desc,
      file: widget.file,
      image: widget.image,
      downloaded: widget.downloaded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const BackArrow(),
        ),
        backgroundColor: Colors.blue[400],
        title: Text(
          widget.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Container(
                      height: 150.0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReadPageItem(
                            iconData: Icons.download,
                            title:
                                easy_localization.tr(LocaleKeys.download_book),
                            onTapEvent: () {
                              downloadFile(
                                fileUrl:
                                    "http://192.168.43.83:8080/files/${widget.file}",
                                imageUrl:
                                    "http://192.168.43.83:8080/images/${widget.image}",
                              );
                            },
                            snackBarTitle:
                                easy_localization.tr(LocaleKeys.downloading),
                          ),
                          const ReadPageItemInfo(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              FontAwesomeIcons.ellipsisVertical,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body:
          SfPdfViewer.network("http://192.168.43.83:8080/files/${widget.file}"),
    );
  }
}
