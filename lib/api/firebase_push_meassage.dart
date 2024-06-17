import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:you_read_app_flutter/database/notification_database_helper.dart';
import 'package:you_read_app_flutter/models/notification_model.dart';
import 'package:you_read_app_flutter/screens/notification_page/notification_page.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print("Title : ${message.notification?.title}");
  }
  if (kDebugMode) {
    print("Body : ${message.notification?.body}");
  }
  if (kDebugMode) {
    print("Payload : ${message.data}");
  }

  // Store the payload in SQLite
  final notification = NotificationModel(
    file: message.data['file'],
    name: message.data['name'],
    author: message.data["author"],
    type: message.data["type"],
  );

  await NotificationHelper.addPayload(notification);
}

class FirebaseMessage {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    // Request permissions for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }

    // Get the token each time the application loads
    final String? fcmToken = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print('FCM Token: $fcmToken');
    }

    // Optional: handle foreground messages
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        if (kDebugMode) {
          print('Message data: ${message.data}');
        }

        if (message.notification != null) {
          if (kDebugMode) {
            print(
                'Message also contained a notification: ${message.notification}');
          }
        }
      },
    );

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Notification clicked!');
      }
      // Navigate to the desired page
      _handleMessage();
    });
  }

  static void _handleMessage() {
    Get.to(
      () => const NotificationPage(),
    );
  }
}
