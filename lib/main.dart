import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_example/pages/main_page.dart';
import 'package:test_example/pages/tag_page.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Evolventa',
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Evolventa'
          )
      ),

    ),

    initialRoute: '/',
    routes: {
      '/': (context) => MainPage(),
      '/tag': (context) => TagPage()
    },
  ));
}
