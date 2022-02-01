import 'package:calculator_app/view/calculator_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff1d1d1d),
          canvasColor: const Color(0xff1d1d1d)),
      themeMode: ThemeMode.system,
      home: const CalculatorPage(),
    );
  }
}
