import 'package:flutter/material.dart';
import 'package:toonflix/screen/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            secondary: Color.fromARGB(255, 98, 231, 98),
            onSecondary: Colors.black,
            error: Color(0xFFE7626C),
            onError: Color(0xFFE7626C),
            surface: Color.fromARGB(255, 255, 255, 255),
            onSurface: Colors.black,
            primary: Color.fromARGB(255, 63, 157, 225),
            onPrimary: Color.fromARGB(255, 255, 255, 255),
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        home: const HomeScreen());
  }
}
