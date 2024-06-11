import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/screens/download_page/download_page.dart';
import 'package:you_read_app_flutter/screens/home_pages/home_page.dart';

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
        const SnackBar(
          content: Text(
            "Please connect to internet first!",
          ),
          duration: Duration(seconds: 2),
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
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(
              height: 80.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(150, 30),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    checkInternetConnection();
                  },
                  child: const Text(
                    "Try Again",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(150, 30),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DownloadPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "View Download",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
