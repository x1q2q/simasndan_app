import 'package:flutter/material.dart';
import 'core/ui_helper.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/profil_screen.dart';
import 'ui/screens/berita_screen.dart';
import 'ui/screens/materi_screen.dart';
import 'ui/screens/rekap_screen.dart';
import 'ui/screens/detail_berita_screen.dart';
import 'ui/screens/detail_materi_screen.dart';
import 'ui/screens/detail_rekap_screen.dart';
import 'ui/screens/notifikasi_screen.dart';
import 'ui/screens/edit_profil_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        '/profile-screen': (context) => const ProfilScreen(),
        '/berita-screen': (context) => const BeritaScreen(),
        '/materi-screen': (context) => const MateriScreen(),
        '/rekap-screen': (context) => const RekapScreen(),
        '/detail-berita-screen': (context) => const DetailBeritaScreen(),
        '/detail-materi-screen': (context) => const DetailMateriScreen(),
        '/detail-rekap-screen': (context) => const DetailRekapScreen(),
        '/edit-profil-screen': (context) => const EditProfilScreen(),
        '/notifikasi-screen': (context) => const NotifikasiScreen()
      },
    );
  }
}

// created by rafiknurf