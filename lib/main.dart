import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'firebase_options.dart'; // ตั้งค่า Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'รายชื่อเกม',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 87, 0, 201),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 87, 0, 201), foregroundColor: Colors.white),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Color.fromARGB(255, 87, 0, 201), foregroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 87, 0, 201), foregroundColor: Colors.white),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
