import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:you_read_app_flutter/custome_widget/back_arrow.dart';
import 'package:you_read_app_flutter/database/notification_database_helper.dart';
import 'package:you_read_app_flutter/models/notification_model.dart';
import 'package:you_read_app_flutter/screens/read_page/read_from_notification.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    // Get current theme mode
    final themeMode = AdaptiveTheme.of(context).mode;
    // Determine active color based on theme mode
    final activeColor = themeMode == AdaptiveThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const BackArrow(),
        ),
        backgroundColor: Colors.blue[400],
        title: Text(
          easy_localization.tr(LocaleKeys.notification),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<NotificationModel>?>(
        future: NotificationHelper.getAllPayloads(),
        builder: (context, AsyncSnapshot<List<NotificationModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final List<NotificationModel>? datas = snapshot.data;
            if (datas != null && datas.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 15.0, bottom: 80.0),
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  final data = datas[index];
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 20.0,
                      left: 5.0,
                      right: 5.0,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: "Delete Message",
                            onPressed: (context) {
                              NotificationHelper.deletePayloadById(data.id!);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      child: NotificationItem(
                        activeColor: activeColor,
                        data: data,
                        onTapEvent: () {
                          Get.to(
                            () => ReadFromNotification(
                              title: data.name,
                              file: data.file,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/bell-6478077_1280.webp",
                  height: 80,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  easy_localization.tr(LocaleKeys.notification_page_is_empty),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.activeColor,
    required this.data,
    required this.onTapEvent,
  });

  final bool activeColor;
  final NotificationModel data;
  final Function() onTapEvent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapEvent,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        leading: Image.asset("assets/images/open-book.png"),
        title: Text(
          "Name : ${data.name}",
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Author : ${data.author}",
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              "Type : ${data.type}",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
