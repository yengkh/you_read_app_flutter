import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Action { delete }

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> notifications =
      List.generate(10, (index) => "Notification $index");

  @override
  Widget build(BuildContext context) {
    // Get current theme mode
    final themeMode = AdaptiveTheme.of(context).mode;
    // Determine active color based on theme mode
    final activeColor = themeMode == AdaptiveThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 8.0,
          right: 8.0,
          bottom: 50.0,
        ),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15.0),
            child: Slidable(
              key: ValueKey(notifications[index]),
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                    onPressed: (context) => _onDismissed(index, Action.delete),
                    backgroundColor: Colors.red,
                    label: "Delete",
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: NotificationItem(
                activeColor: activeColor,
                title: notifications[index],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onDismissed(int index, Action action) {
    setState(() {
      notifications.removeAt(index);
    });
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.activeColor,
    required this.title,
  });

  final bool activeColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(5.0),
          topLeft: Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: activeColor ? Colors.blue : Colors.grey.withOpacity(0.5),
            spreadRadius: activeColor ? 0 : 3,
            blurRadius: activeColor ? 0 : 3,
            offset: activeColor ? const Offset(0, 0) : const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(
            width: 10.0,
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30.0,
            child: Image.asset(
              "assets/images/man.png",
              height: 40.0,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Add this line
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      FontAwesomeIcons.bookOpen,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Name : asjdlajd;afj;asfjflhlafhflajlajDLASFLJASLFJAFJAHFLJALFSLFJSFFF.NSLSGL;SDJ",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                  "Author : aldlajdladladladl",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
