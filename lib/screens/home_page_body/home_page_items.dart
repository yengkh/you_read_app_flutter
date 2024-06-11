import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/api/book_item_api.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/book_items_shimmer.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/custome_widget.dart';
import 'package:you_read_app_flutter/models/book_model.dart';

class HomePageItems extends StatefulWidget {
  const HomePageItems({super.key});

  @override
  State<HomePageItems> createState() => _HomePageItemsState();
}

class _HomePageItemsState extends State<HomePageItems> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookModel>>(
      future: BookItemAPI.getAllBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const BookItemWidget();
        } else if (snapshot.hasError) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 180.0,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/image-loading-failed-02.png",
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text("Something Wrong!"),
                        const Text("Try to check internet connection!")
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          final List<BookModel> bookModels = snapshot.data!;
          return ListView.builder(
            itemCount: bookModels.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final bookModel = bookModels[index];
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: CustomeWidgetItems(
                  author: bookModel.author,
                  desc: bookModel.desc,
                  file: bookModel.file,
                  image: bookModel.image,
                  name: bookModel.name,
                  type: bookModel.type,
                  downloaded: bookModel.downloaded,
                  id: bookModel.id,
                ),
              );
            },
          );
        }
      },
    );
  }
}
