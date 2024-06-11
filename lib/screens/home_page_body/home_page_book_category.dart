import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_read_app_flutter/api/book_type_api.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/book_type_page_controller.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/book_type_shimmer.dart';
import 'package:you_read_app_flutter/models/book_type_model.dart';

class HomePageBookCatrgories extends StatefulWidget {
  const HomePageBookCatrgories({super.key});

  @override
  State<HomePageBookCatrgories> createState() => _HomePageBookCatrgoriesState();
}

class _HomePageBookCatrgoriesState extends State<HomePageBookCatrgories> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BookTypeAPI.getData(),
      builder:
          (BuildContext context, AsyncSnapshot<List<BookTypeModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const BookTypeWidget();
        } else if (snapshot.hasError) {
          return SizedBox(
            height: 150.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120.0,
                          width: 120.0,
                          child: Image.asset(
                            "assets/images/image-loading-failed-02.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Text("Something Wrong!"),
                        ),
                      ],
                    ),
                  );
                }),
          );
        } else {
          List<BookTypeModel> datas = snapshot.data!;
          return SizedBox(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  final data = datas[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              BookTypePageController(
                                title: data.name,
                              ),
                            );
                          },
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "http://192.168.43.83:8080/booktypeimages/${data.image}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          data.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          );
        }
      },
    );
  }
}
