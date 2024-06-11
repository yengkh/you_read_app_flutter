import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/app_bar_icon.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/home_page_app_bar.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/row_text_widget.dart';
import 'package:you_read_app_flutter/screens/home_page_body/carocel_slider.dart';
import 'package:you_read_app_flutter/screens/home_page_body/home_page_book_category.dart';
import 'package:you_read_app_flutter/screens/home_page_body/home_page_items.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  String title = "Book Types";
  String secondTitle = "Explor here";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const HomePageAppBar(),
        actions: [
          IconButtonWidget(
            iconButtonOnPress: () {},
            iconColor: Colors.white,
            iconSized: 25.0,
            iconData: Icons.search,
          ),
          IconButtonWidget(
            iconButtonOnPress: () {},
            iconData: FontAwesomeIcons.bell,
            iconColor: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const CarouselWidget(),
            RowTextWidget(
              title: title,
              //sized: FontSizeClass.brfontsize18,
            ),
            const HomePageBookCatrgories(),
            RowTextWidget(
              title: secondTitle,
              //sized: FontSizeClass.brfontsize18,
            ),
            const HomePageItems(),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
