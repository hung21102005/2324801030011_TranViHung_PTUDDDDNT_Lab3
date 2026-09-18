import 'package:flutter/material.dart';

import 'screens/create_post_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const SociallyApp());
}

class SociallyApp extends StatelessWidget {
  const SociallyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Socially',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3525CD)),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MainScreen(),
        '/create-post': (context) => const CreatePostScreen(),
      },
    );
  }
}
