import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_read_app_flutter/custome_widget/text_widget/text_widget_item.dart';
import 'package:you_read_app_flutter/screens/read_page/read_page_from_home_page.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

// ignore: must_be_immutable
class CustomeWidgetItems extends StatefulWidget {
  CustomeWidgetItems({
    super.key,
    required this.name,
    required this.author,
    required this.desc,
    required this.file,
    required this.image,
    required this.type,
    required this.downloaded,
    required this.id,
  });

  @override
  State<CustomeWidgetItems> createState() => _CustomeWidgetItemsState();
  String name;
  String file;
  String image;
  String author;
  String desc;
  String type;
  String downloaded;
  String id;
}

class _CustomeWidgetItemsState extends State<CustomeWidgetItems> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    // Get current theme mode
    final themeMode = AdaptiveTheme.of(context).mode;
    // // Determine active color based on theme mode
    final activeColor = themeMode == AdaptiveThemeMode.dark;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: activeColor ? Colors.blue : Colors.grey.withOpacity(0.5),
                spreadRadius: activeColor ? 0 : 5,
                blurRadius: activeColor ? 0 : 3,
                offset: activeColor ? const Offset(0, 0) : const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: CachedNetworkImage(
              imageUrl: "http://192.168.43.83:8080/images/${widget.image}",
              height: 180.0,
              width: 105.0,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            height: 180.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      activeColor ? Colors.blue : Colors.grey.withOpacity(0.5),
                  spreadRadius: activeColor ? 0 : 5,
                  blurRadius: activeColor ? 0 : 3,
                  offset: activeColor ? const Offset(0, 0) : const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      easy_localization.tr(LocaleKeys.name),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      easy_localization.tr(LocaleKeys.author),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.author,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextItemsWidget(
                      title: easy_localization.tr(LocaleKeys.type),
                      styles: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.type,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    TextButton(
                      style: const ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(100, 20)),
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        easy_localization.tr(LocaleKeys.detail),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(100, 20)),
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Get.to(
                          ReadPageFromHomePage(
                            file: widget.file,
                            name: widget.name,
                            downloaded: widget.downloaded,
                            author: widget.author,
                            desc: widget.desc,
                            id: widget.id,
                            image: widget.image,
                            type: widget.type,
                          ),
                        );
                      },
                      child: Text(
                        easy_localization.tr(LocaleKeys.read),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
