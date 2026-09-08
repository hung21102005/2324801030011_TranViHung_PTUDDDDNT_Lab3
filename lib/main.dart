import 'package:flutter/material.dart';

import 'screens/create_post_screen.dart';
import 'screens/home_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/create-post': (context) => const CreatePostScreen(),
      },
    );
  }
}
