import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ThemDataClass.bodyColor,
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text(
          easy_localization.tr(LocaleKeys.setting),
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8.0,
          ),
          ListTile(
            title: Text(easy_localization.tr(LocaleKeys.language)),
          ),
          const LanguageItem(
            imageLink: "assets/images/english.png",
            title: "English",
            locale: 'en',
          ),
          const LanguageItem(
            imageLink: "assets/images/Flag_of_Cambodia.png",
            title: "Khmer",
            locale: 'km',
          ),
          const LanguageItem(
            imageLink:
                "assets/images/Flag_of_Peoples_Republic_of_China-4096x2731.png",
            title: "Chinese",
            locale: 'zh',
          ),
          const LanguageItem(
            imageLink: "assets/images/Flag_of_Germany.png",
            title: "German",
            locale: 'de',
          ),
          const SizedBox(
            height: 8.0,
          ),
          const ListTile(
            title: Text("Change Theme"),
          ),
          ChangeTheme(
            iconData: FontAwesomeIcons.moon,
            onTapEvent: () {
              AdaptiveTheme.of(context).setDark();
            },
            title: "Dark Them",
          ),
          ChangeTheme(
            iconData: FontAwesomeIcons.sun,
            onTapEvent: () {
              AdaptiveTheme.of(context).setLight();
            },
            title: "Light Them",
          ),
        ],
      ),
    );
  }
}

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({
    super.key,
    required this.iconData,
    required this.onTapEvent,
    required this.title,
  });
  final IconData iconData;
  final Function() onTapEvent;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10.0,
        left: 20.0,
        bottom: 10.0,
      ),
      child: GestureDetector(
        onTap: onTapEvent,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          leading: Icon(
            iconData,
            color: Colors.white,
          ),
          tileColor: Colors.blue,
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class LanguageItem extends StatefulWidget {
  const LanguageItem({
    super.key,
    required this.imageLink,
    required this.title,
    required this.locale,
  });

  final String imageLink;
  final String title;
  final String locale;

  @override
  State<LanguageItem> createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: GestureDetector(
        onTap: () async {
          final newLocale = Locale(widget.locale);
          await context.setLocale(newLocale);
          Get.updateLocale(newLocale);
        },
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          tileColor: Colors.blue,
          leading: Image.asset(
            widget.imageLink,
            height: 30.0,
            width: 30.0,
          ),
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
