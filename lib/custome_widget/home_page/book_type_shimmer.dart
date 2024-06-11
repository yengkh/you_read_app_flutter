import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookTypeWidget extends StatelessWidget {
  const BookTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
            baseColor: const Color.fromRGBO(211, 203, 201, 1),
            highlightColor: const Color.fromRGBO(211, 203, 201, 0.7),
            child: SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
  }
}
