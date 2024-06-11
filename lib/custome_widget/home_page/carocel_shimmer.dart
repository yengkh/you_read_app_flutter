import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarocelShimmer extends StatelessWidget {
  const CarocelShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 200.0,
            child: Shimmer.fromColors(
              baseColor: const Color.fromRGBO(211, 203, 201, 1),
              highlightColor: const Color.fromRGBO(211, 203, 201, 0.7),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
  }
}