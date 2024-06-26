import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/custome_widget/no_internet_checker/no_internet_checker_widget.dart';
import 'package:you_read_app_flutter/screens/download_page/download_page.dart';
import 'package:you_read_app_flutter/screens/home_pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            easy_localization.tr(LocaleKeys.please_connect_to_internet_first),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      // Internet connection available, navigate to Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      ); // Replace '/home' with your actual home page route
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/no-internet-connection-5521509-4610093.webp",
              height: 250,
              fit: BoxFit.contain,
            ),
            Text(
              easy_localization.tr(LocaleKeys.no_internet_connection),
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(
              height: 80.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NoInternetButton(
                  onTapEvent: () {
                    checkInternetConnection();
                  },
                  title: easy_localization.tr(LocaleKeys.try_again),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                NoInternetButton(
                  onTapEvent: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DownloadPage(),
                      ),
                    );
                  },
                  title: easy_localization.tr(LocaleKeys.view_downloaded_book),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
