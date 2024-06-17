import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:you_read_app_flutter/custome_widget/back_arrow.dart';
import 'package:you_read_app_flutter/screens/home_page_body/home_page_body.dart';

class ReadFromNotification extends StatelessWidget {
  const ReadFromNotification({
    super.key,
    required this.title,
    required this.file,
  });
  final String title;
  final String file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.offAll(
              () => const HomePageBody(),
            );
          },
          child: const BackArrow(),
        ),
        backgroundColor: Colors.blue[400],
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SfPdfViewer.network("http://192.168.43.83:8080/files/$file"),
    );
  }
}
