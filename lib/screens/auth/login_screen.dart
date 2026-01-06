import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tangankebaikan/widgets/custom_text_field.dart';
import '../home/donatur_home_page.dart';
import 'package:tangankebaikan/screens/user/user_list_screen.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Fungsi navigasi yang akan dipanggil saat login berhasil
  void _navigateToHome(BuildContext context) {
    // Menggunakan pushReplacement agar halaman Login dihancurkan dari stack
    // dan pengguna tidak bisa kembali ke halaman login setelah masuk.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const DonaturHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Masuk',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Silakan masuk ke akun Anda.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              const CustomTextField(
                label: 'Email',
                hintText: 'example@gmail.com',
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                label: 'Kata Sandi',
                hintText: '••••••••', // Mengisi hintText agar lebih baik
                isPassword: true,
              ),
              const SizedBox(height: 40),

              // Tombol Masuk
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // PANGGIL FUNGSI NAVIGASI DI SINI
                    _navigateToHome(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UserListScreen()),
    );
  },
  child: const Text(
    "Lihat Data User (API)",
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
),

              const Center(
                child: Text('Social networks', style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 20),

              _buildSocialButton(
                text: 'Lanjut dengan Apple',
                icon: FontAwesomeIcons.apple,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSocialButton(
                text: 'Lanjut dengan Facebook',
                icon: FontAwesomeIcons.facebookF,
                iconColor: Colors.blue[900],
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSocialButton(
                text: 'Lanjut dengan Google',
                icon: FontAwesomeIcons.google,
                iconColor: Colors.red,
                onTap: () {},
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun?'),
                  TextButton(
                    onPressed: () {
                      // Asumsi '/register' sudah didefinisikan di MaterialApp
                      Navigator.pushNamed(context, '/register'); 
                    },
                    child: const Text('Daftar Sekarang'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: FaIcon(icon, color: iconColor ?? Colors.black),
        label: Text(
          text,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: Color(0xFFE0E0E0)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}