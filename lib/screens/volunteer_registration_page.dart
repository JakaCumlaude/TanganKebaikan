import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import untuk API
import 'dart:convert';

class VolunteerRegistrationPage extends StatefulWidget {
  const VolunteerRegistrationPage({super.key});

  @override
  State<VolunteerRegistrationPage> createState() => _VolunteerRegistrationPageState();
}

class _VolunteerRegistrationPageState extends State<VolunteerRegistrationPage> {
  final Color primaryBlue = const Color(0xFF4A90E2);

  // Controller untuk menangkap input teks
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController(); // Ini akan kita anggap 'city' di API agar sinkron

  bool _isLoading = false;

  // Fungsi untuk mengirim data (HTTP POST)
  Future<void> submitData() async {
    if (_nameController.text.isEmpty || _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi semua bidang!")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // GANTI URL dengan URL MockAPI kamu
      final response = await http.post(
    Uri.parse("https://694d37b1ad0f8c8e6e200fe8.mockapi.io/volunteers"), // Tetap ke MockAPI
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "name": _nameController.text,
      "city": _reasonController.text,
      "imageUrl": "https://picsum.photos/500/300",
      "needed": 1,
    }),
      );

      if (response.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pendaftaran Berhasil Dikirim ke API!")),
        );
        Navigator.pop(context); // Kembali ke halaman list
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulir Pendaftaran"),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nama Lengkap", 
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: "Alasan Ingin Bergabung", 
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Kirim Pendaftaran", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}