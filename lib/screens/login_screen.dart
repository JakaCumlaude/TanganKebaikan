import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Masuk")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.volunteer_activism, size: 80, color: Colors.blue),
                const SizedBox(height: 24),
                const Text("Masuk ke Akun Anda", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),
                TextFormField(decoration: const InputDecoration(labelText: "Email", prefixIcon: Icon(Icons.email))),
                const SizedBox(height: 20),
                TextFormField(obscureText: true, decoration: const InputDecoration(labelText: "Kata Sandi", prefixIcon: Icon(Icons.lock))),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    // Navigasi ke Home dan hapus history sebelumnya
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
                    child: const Text("Masuk"),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text("Belum punya akun? Daftar Sekarang"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}