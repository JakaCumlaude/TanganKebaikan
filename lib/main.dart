import 'package:flutter/material.dart';
// Import semua screen
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/project_list_screen.dart';
import 'screens/create_project_screen.dart';
import 'screens/project_detail_screen.dart';
import 'screens/volunteer_screen.dart';
import 'screens/gallery_list_screen.dart';
import 'screens/gallery_detail_screen.dart';
import 'screens/donation_screen.dart'; // PERBAIKAN: Import halaman donasi

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tangan Kebaikan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Konfigurasi Tema agar sesuai gambar (Dominan Biru & Putih)
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196F3),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0.5,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      // Definisi Rute Navigasi
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/projects': (context) => const ProjectListScreen(),
        '/create-project': (context) => const CreateProjectScreen(),
        '/project-detail': (context) => const ProjectDetailScreen(),
        '/volunteer': (context) => const VolunteerScreen(),
        '/gallery': (context) => const GalleryListScreen(),
        '/gallery-detail': (context) => const GalleryDetailScreen(),
        '/donation': (context) => const DonationScreen(), // PERBAIKAN: Daftarkan rute donasi
      },
    );
  }
}