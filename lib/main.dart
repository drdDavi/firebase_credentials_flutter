import 'package:firebase_credentials_flutter/appUtils/get_it.dart';
import 'package:firebase_credentials_flutter/appUtils/navigator.dart';
import 'package:firebase_credentials_flutter/model_providers/userx_provider.dart';
import 'package:firebase_credentials_flutter/pages/splash_screen_page.dart';
import 'package:firebase_credentials_flutter/pages/user_details_page.dart';
import 'package:firebase_credentials_flutter/pages/users_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'model_providers/theme_provider.dart';
import 'model_providers/users_provider.dart';
import 'pages/sign_in_page.dart';

void main() {
  runApp(AppStart());
  setupLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class AppStart extends StatelessWidget {
  const AppStart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(builder: (context) => ThemeProvider(isLightTheme: false)),
      ChangeNotifierProvider(builder: (context) => UserxProvider()),
      ChangeNotifierProvider(builder: (context) => UsersProvider()),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Flutter',
      theme: themeProvider.getThemeData,
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: SplashScreenPage(),
      routes: {
        "/sign_in_page": (context) => SignInPage(),
        "/splash_screen_page": (context) => SplashScreenPage(),
        "/users_dashboard_page": (context) => UsersDashboardPage(),
        "/User_details_page": (context) => UserDetailsPage(),
      },
    );
  }
}
