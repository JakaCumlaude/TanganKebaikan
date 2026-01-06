import 'package:flutter/material.dart';
import 'package:tangankebaikan/screens/splash_screen.dart';
import 'package:tangankebaikan/screens/login_screen.dart';
import 'package:tangankebaikan/screens/register_screen.dart';
import 'package:tangankebaikan/screens/volunteer_detail_page.dart';
import 'package:tangankebaikan/screens/volunteer_registration_page.dart';
import 'package:tangankebaikan/screens/volunteer_list_page.dart';
import 'package:tangankebaikan/screens/registration_history_page.dart';

void main() {
  runApp(const TanganKebaikanApp());
}

class TanganKebaikanApp extends StatelessWidget {
  const TanganKebaikanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TanganKebaikan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        // Anda bisa menambahkan font default di sini jika ada
        // fontFamily: 'NamaFont',
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/volunteer-list': (context) => const VolunteerListPage(),
        '/volunteer-registration': (context) => const VolunteerRegistrationPage(),
        '/registration-history': (context) => const RegistrationHistoryPage(),
      },
    );
  }
}