import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tangankebaikan/widgets/custom_text_field.dart'; 

enum UserRole { donatur, penerimaBantuan }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserRole _selectedRole = UserRole.donatur;
  
  // Controller untuk mengambil input user
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;

  // Endpoint MockAPI Anda (Pastikan resource 'users' sudah dibuat di dashboard MockAPI)
  final String userUrl = "https://6950dbe970e1605a1088a896.mockapi.io/users";

  // --- METHOD 1: GET (Validasi Email) ---
  Future<bool> _isEmailRegistered(String email) async {
  try {
    final response = await http.get(
      Uri.parse("$userUrl?email=$email"),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
  _showSuccessDialog();
} else {
  _showError("Registrasi gagal");
}
    final List<dynamic> users = json.decode(response.body);
    return users.isNotEmpty;
  } catch (e) {
    debugPrint("Error GET: $e");
  }
  return false;
}

  // --- METHOD 2: POST (Pendaftaran Akun) ---
  Future<void> _handleRegister() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Validasi Dasar
    if (email.isEmpty || password.isEmpty) {
      _showError("Harap isi Email dan Kata Sandi");
      return;
    }
    if (password != _confirmPasswordController.text) {
      _showError("Konfirmasi kata sandi tidak cocok");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Langkah 1: Jalankan GET untuk validasi
      bool exists = await _isEmailRegistered(email);

      if (exists) {
        _showError("Email sudah terdaftar. Gunakan email lain.");
      } else {
        // Langkah 2: Jalankan POST jika email tersedia
        final response = await http.post(
          Uri.parse(userUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "password": password,
            "role": _selectedRole == UserRole.donatur ? "Donatur" : "Penerima Bantuan",
            "createdAt": DateTime.now().toIso8601String(),
          }),
        );

        if (response.statusCode == 201) {
          _showSuccessDialog();
        }
      }
    } catch (e) {
      _showError("Gagal terhubung ke server");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccessDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Akun Berhasil Dibuat!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Peran: ${_selectedRole == UserRole.donatur ? "Donatur" : "Penerima Bantuan"}'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text('Kembali ke Masuk', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Buat Akun', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              
              // Pemilihan Peran
              Row(
                children: [
                  _buildRoleOption('Donatur', UserRole.donatur),
                  const SizedBox(width: 24),
                  _buildRoleOption('Penerima Bantuan', UserRole.penerimaBantuan),
                ],
              ),
              const SizedBox(height: 40),

              // Form Input dengan Controller
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', hintText: 'example@gmail.com'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Kata Sandi'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Verifikasi Kata Sandi'),
              ),
              const SizedBox(height: 40),

              // Tombol Daftar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Buat Akun', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleOption(String label, UserRole value) {
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = value),
      child: Row(
        children: [
          Icon(
            _selectedRole == value ? Icons.radio_button_checked : Icons.radio_button_off,
            color: _selectedRole == value ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}