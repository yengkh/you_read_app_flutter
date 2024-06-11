
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/api/carocel_api.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/carocel_shimmer.dart';
import 'package:you_read_app_flutter/models/carocel_model.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CaroModel>>(
      future: CarocelAPI.getImage(),
      builder: (BuildContext context, AsyncSnapshot<List<CaroModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CarocelShimmer();
        } else if (snapshot.hasError) {
          return SizedBox(
            height: 200.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/image-loading-failed-02.png",
                                height: 80.0,
                                width: 80.0,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              const Text("Something wrong!"),
                              const Text("Try to check internet connection!"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else {
          final List<CaroModel> images = snapshot.data!;
          return CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            ),
            items: images.map((caroModel) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://192.168.43.83:8080/carocelImages/${caroModel.image}",
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}
