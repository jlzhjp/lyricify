import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/start_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyricify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const StartPage(),
    );
  }
}
