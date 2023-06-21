import 'package:flutter/material.dart';
import 'core/styles.dart';
import 'core/ui_helper.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/profile_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.light().copyWith(
          primary: greenv2,
          secondary: orangev2,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginScreen(),
        '/home-screen': (context) => const HomeScreen(),
        '/profile-screen': (context) => const ProfileScreen(),
      },
    );
  }
}

// created by rafiknurf