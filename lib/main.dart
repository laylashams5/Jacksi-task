import 'package:flutter/material.dart';
import 'package:jacksi/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المنتجات',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Transparent AppBar
          iconTheme: IconThemeData(color: Colors.black), // Icons color
        ),
      ),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
