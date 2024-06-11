import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/screens/home_pages/home_page.dart';
import 'package:you_read_app_flutter/screens/no_internet_screen/no_internet_screen.dart';

class InternetConnectionChecker extends StatefulWidget {
  const InternetConnectionChecker({super.key});

  @override
  InternetConnectionCheckerState createState() =>
      InternetConnectionCheckerState();
}

class InternetConnectionCheckerState extends State<InternetConnectionChecker> {
  List<ConnectivityResult>? _connectivityResults;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
  }

  // Check initial connectivity state
  Future<void> _initConnectivity() async {
    List<ConnectivityResult> results;
    try {
      results = await Connectivity().checkConnectivity();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      results = [ConnectivityResult.none];
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _connectivityResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_connectivityResults != null &&
        _connectivityResults!.contains(ConnectivityResult.none)) {
      return const NoInternetScreen();
    } else {
      return const HomePage();
    }
  }
}
