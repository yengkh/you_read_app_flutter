import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:you_read_app_flutter/api/firebase_push_meassage.dart';
import 'package:you_read_app_flutter/bloc/add_to_favorite_bloc_bloc.dart';
import 'package:you_read_app_flutter/firebase_options.dart';
import 'package:you_read_app_flutter/screens/no_internet_checker/no_inernet_checker.dart';
import 'package:you_read_app_flutter/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //   apiKey: 'AIzaSyDggHnb5pOGh9Kc1NvkESjO1YyD37R71Eo',
    //   appId: '1:396792424952:android:8582aed716003cf405ce0d',
    //   messagingSenderId: 'sendid',
    //   projectId: 'you-read-app-87d3d',
    //   storageBucket: 'you-read-app-87d3d.appspot.com',
    // ),
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessage().initNotification();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translation',
      supportedLocales: const [
        Locale('en'),
        Locale('km'),
        Locale('zh'),
        Locale('de'),
      ],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavoritesBloc()),
      ],
      child: AdaptiveTheme(
        light: ThemeData.light(useMaterial3: true),
        dark: ThemeData.dark(useMaterial3: true),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => GetMaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'You Read',
          theme: theme,
          darkTheme: darkTheme,
          home: const InternetConnectionChecker(),
        ),
      ),
    );
  }
}
