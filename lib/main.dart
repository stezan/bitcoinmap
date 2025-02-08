import 'package:bitcoin_map/presentation/screen/main_screen.dart';
import 'package:bitcoin_map/telegram_mini_app/telegram_mini_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'colors.dart';
import 'firebase_options.dart';

Future<void> main() async {
  if (isSupported) {
    disableVerticalSwipes();
    if (!isExpanded) {
      expand();
    }
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/bitcoin_pin.png'), context);
    return MaterialApp(
      title: 'Bitcoin Map',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}
