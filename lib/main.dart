import 'package:flutter/material.dart';
import 'package:social_posting/auth/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_posting/theme/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme:
                const AppBarTheme(iconTheme: IconThemeData(color: text2))),
        debugShowCheckedModeBanner: false,
        home: const AuthPage());
  }
}
