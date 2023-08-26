import 'package:flutter/material.dart';
import 'core/ui_helper.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/berita_screen.dart';
import 'ui/screens/materi_screen.dart';
import 'ui/screens/notifikasi_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/firebase_options.dart';
import 'package:bot_toast/bot_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('user');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final Box box;
  bool islogin = false;

  checkUserLoginState() async {
    box = Hive.box('user');
    if (box.get('id') != null) {
      setState(() {
        islogin = true;
      });
    }
  }

  @override
  void initState() {
    checkUserLoginState();
    super.initState();
  }

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
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: (islogin) ? const HomeScreen() : const LoginScreen(),
      routes: {
        '/login-screen': (context) => const LoginScreen(),
        '/home-screen': (context) => const HomeScreen(),
        '/berita-screen': (context) => const BeritaScreen(),
        '/materi-screen': (context) => const MateriScreen(),
        '/notifikasi-screen': (context) => const NotifikasiScreen()
      },
    );
  }
}

// created by rafiknurf