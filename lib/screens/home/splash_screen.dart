import 'package:flutter/material.dart';
// Import untuk menangani gesture pada bagian teks
import 'package:flutter/gestures.dart'; 

// Import halaman tujuan
import '../auth/login_screen.dart'; 
import '../auth/register_screen.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // TAP RECOGNIZER UNTUK FITUR "MASUK"
  late TapGestureRecognizer _loginRecognizer;
  
  // Navigasi ke halaman Login/Masuk
  void _navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen())
    );
  }

  // Navigasi ke halaman Register/Buat Akun
  void _navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const RegisterScreen())
    );
  }
  
  @override
  void initState() {
    super.initState();
    // Inisialisasi TapGestureRecognizer dan kaitkan dengan fungsi navigasi
    _loginRecognizer = TapGestureRecognizer()
      ..onTap = _navigateToLogin; 
  }
  
  @override
  void dispose() {
    // Pastikan recognizer dibersihkan untuk menghindari kebocoran memori
    _loginRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String backgroundImagePath = 'assets/images/background_kolase.jpg'; 
    const String logoImagePath = 'assets/images/logo_tangan_kebaikan.png';
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Latar Belakang Gambar Penuh (Kolase)
          Image.asset(
            backgroundImagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[900], 
              child: const Center(child: Text('Gagal Memuat Gambar Latar', style: TextStyle(color: Colors.white))),
            ),
          ),

          // 2. Overlay Semitransparan Hitam
          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          // 3. Konten Logo (Diubah: Dipindahkan ke Stack agar bisa di tengah halaman)
          // Menggunakan Align.center untuk menempatkan logo di tengah vertikal dan horizontal
          Align(
            alignment: const Alignment(0, -0.4), // Penempatan di tengah horizontal, sedikit di atas tengah vertikal
            child: Image.asset(
              logoImagePath,
              width: 200, // Diperbesar dari 100 menjadi 150
              height: 200, // Diperbesar dari 100 menjadi 150
              errorBuilder: (context, error, stackTrace) => Container(
                width: 150,
                height: 150,
                color: Colors.white,
                child: const Center(child: Text('Logo', style: TextStyle(color: Colors.black))),
              ),
            ),
          ),


          // 4. Konten Teks & Tombol (Dipertahankan di bawah)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // Tinggi dikurangi agar logo di tengah bisa terlihat
              height: screenHeight * 0.55, 
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              decoration: const BoxDecoration(
                color: Colors.transparent, 
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Catatan: Logo di sini sudah DIHAPUS karena sudah dipindahkan ke Stack.
                  
                  // Teks Sambutan
                  const Text(
                    'Selamat Datang di',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const Text(
                    'TanganKebaikan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(height: 40), 

                  // Deskripsi
                  const Text(
                    'Jadilah bagian dari gerakan kebaikan ini. Bergabunglah dengan donatur kami sekarang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(221, 255, 255, 255),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Tombol "Buat akun"
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _navigateToRegister, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700], 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Buat akun',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Teks "Sudah punya akun? Masuk"
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      children: [
                        TextSpan(
                          text: 'Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue[400],
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline, 
                          ),
                          recognizer: _loginRecognizer, 
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}