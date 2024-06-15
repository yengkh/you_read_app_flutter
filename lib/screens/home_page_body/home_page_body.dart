import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/app_bar_icon.dart';
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
  User? _user;
  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _checkUser();
  }

  Future<void> _checkUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  String title = easy_localization.tr(LocaleKeys.book_types);
  String secondTitle = easy_localization.tr(LocaleKeys.explore_here);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              easy_localization.tr(LocaleKeys.hello_text),
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              _user != null
                  ? _user!.displayName!
                  : easy_localization.tr(LocaleKeys.reader),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            Text(
              easy_localization
                  .tr(LocaleKeys.which_book_do_you_want_to_read_today),
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
        actions: [
          IconButtonWidget(
            iconButtonOnPress: () {
              Get.to(
                () => const SearchPage(),
              );
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
