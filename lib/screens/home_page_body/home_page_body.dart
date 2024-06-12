import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/app_bar_icon.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/home_page_app_bar.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/row_text_widget.dart';
import 'package:you_read_app_flutter/screens/home_page_body/carocel_slider.dart';
import 'package:you_read_app_flutter/screens/home_page_body/home_page_book_category.dart';
import 'package:you_read_app_flutter/screens/home_page_body/home_page_items.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/screens/notification_page/notification_page.dart';
import 'package:you_read_app_flutter/screens/search_page/search_page.dart';
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  String title = easy_localization.tr(LocaleKeys.book_types);
  String secondTitle = easy_localization.tr(LocaleKeys.explore_here);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const HomePageAppBar(),
        actions: [
          IconButtonWidget(
            iconButtonOnPress: () {
              Get.to(() => const SearchPage(),);
            },
            iconColor: Colors.white,
            iconSized: 25.0,
            iconData: Icons.search,
          ),
          IconButtonWidget(
            iconButtonOnPress: () {
              Get.to(
                const NotificationPage(),
              );
            },
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
              iconData: FontAwesomeIcons.layerGroup,
              iconSize: 20.0,
              title: title,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const HomePageBookCatrgories(),
            RowTextWidget(
              iconSize: 20.0,
              iconData: FontAwesomeIcons.list,
              title: secondTitle,
            ),
            const SizedBox(
              height: 10.0,
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
