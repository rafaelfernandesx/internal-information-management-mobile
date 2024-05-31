import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/material.dart';
import 'package:internalinformationmanagement/screens/feed_screen.dart';
import 'package:internalinformationmanagement/screens/sumary_screen.dart';
import 'package:internalinformationmanagement/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internalinformationmanagement/screens/home_screen.dart';
import 'package:internalinformationmanagement/screens/login_screen.dart';
import 'package:internalinformationmanagement/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'flavors.dart';

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _jwt;

  @override
  void initState() {
    super.initState();
    _checkJWT();
  }

  Future<void> _checkJWT() async {
    final prefs = await SharedPreferences.getInstance();
    _jwt = prefs.getString('jwt_token');
    print(_jwt);
  }

  @override
  Widget build(BuildContext context) {
    if (_jwt == null || _jwt == "") {
      return MaterialApp(
        title: F.title,
        navigatorKey: widget.navigatorKey,
        routes: {
          '/summary': (context) => SummaryScreen(),
          '/feed': (context) => FeedScreen(),
          '/login': (context) => LoginScreen(navigatorKey: widget.navigatorKey),
          '/home': (context) => HomeScreen()
        },
        //initialRoute: '/login',
        initialRoute: '/login',
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
      );
    } else {
      return MaterialApp(
        title: F.title,
        navigatorKey: widget.navigatorKey,
        routes: {
          '/summary': (context) => SummaryScreen(),
          '/feed': (context) => FeedScreen(),
          '/login': (context) => LoginScreen(navigatorKey: widget.navigatorKey),
          '/home': (context) => HomeScreen()
        },
        //initialRoute: '/login',
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
      );
    }
  }
}
