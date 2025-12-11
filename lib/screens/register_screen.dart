import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _selectedType = 1; // 1: Donatur, 2: Penerima

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Buat Akun Baru", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("Tipe Pengguna:", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio(value: 1, groupValue: _selectedType, onChanged: (v) => setState(() => _selectedType = v!)),
                const Text("Donatur"),
                const SizedBox(width: 20),
                Radio(value: 2, groupValue: _selectedType, onChanged: (v) => setState(() => _selectedType = v!)),
                const Text("Penerima"),
              ],
            ),
            const SizedBox(height: 16),
            _buildInput("Nama Lengkap", Icons.person),
            _buildInput("Email", Icons.email),
            _buildInput("Nomor Telepon", Icons.phone),
            _buildInput("Kata Sandi", Icons.lock, isPassword: true),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registrasi Berhasil! Silakan Login.")));
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text("Daftar"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, IconData icon, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      ),
    );
  }
}