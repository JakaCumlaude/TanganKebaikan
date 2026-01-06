import 'package:flutter/material.dart';
import '../models/volunteer_model.dart'; // Pastikan path model benar

class VolunteerDetailPage extends StatelessWidget {
  // Tambahkan parameter untuk menerima data volunteer
  final Volunteer volunteer;

  const VolunteerDetailPage({super.key, required this.volunteer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kegiatan", 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: const Color(0xFF4A90E2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Dinamis dari URL
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(volunteer.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama/Judul Dinamis
                  Text(
                    volunteer.name, 
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 8),
                  
                  // Lokasi/Sumber Dinamis
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 18),
                      const SizedBox(width: 5),
                      Text(volunteer.city, style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  const Text("Deskripsi:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  // Jika dari NewsAPI, ini bisa menampilkan ringkasan berita
                  Text(
                    "Kegiatan ini dilaksanakan di ${volunteer.city}. Mari bergabung untuk memberikan kontribusi nyata bagi masyarakat yang membutuhkan.",
                    style: const TextStyle(height: 1.5),
                  ),
                  
                  const SizedBox(height: 20),
                  const Text("Kebutuhan Relawan:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("• Dibutuhkan: ${volunteer.needed} orang"),
                  
                  const SizedBox(height: 30),
                  
                  // Tombol Daftar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman pendaftaran
                        Navigator.pushNamed(context, '/volunteer-registration');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A90E2),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Daftar Sekarang", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}