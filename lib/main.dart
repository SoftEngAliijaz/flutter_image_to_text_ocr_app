import 'package:flutter/material.dart';
import 'package:flutter_image_to_text_ocr_app/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'image_to_text_ocr'.toUpperCase(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0)),
        textTheme: GoogleFonts.firaSansTextTheme(Theme.of(context).textTheme),
      ),
      home: HomeScreen(),
    );
  }
}
