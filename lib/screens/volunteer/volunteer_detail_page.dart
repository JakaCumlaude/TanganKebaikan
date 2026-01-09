import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/volunteer_model.dart';

class VolunteerDetailPage extends StatelessWidget {
  final Volunteer volunteer;

  const VolunteerDetailPage({
    super.key,
    required this.volunteer,
  });

  Future<void> _openLink(BuildContext context) async {
    final Uri uri = Uri.parse('https://www.indorelawan.org/');

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Link tidak dapat dibuka')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Volunteer"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // ================= GAMBAR =================
          Image.network(
            volunteer.image,
            height: 240,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 240,
              color: Colors.grey[300],
              child: const Icon(
                Icons.image_not_supported,
                size: 60,
                color: Colors.grey,
              ),
            ),
          ),

          // ================= KONTEN =================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== NAMA =====
                Text(
                  volunteer.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // ===== LOKASI =====
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(
                      volunteer.location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),

                // ===== JUDUL DESKRIPSI =====
                const Text(
                  "Deskripsi Kegiatan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // ===== DESKRIPSI PANJANG =====
                Text(
                  volunteer.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 32),

                // ================= TOMBOL =================
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _openLink(context),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text(
                      "Daftar Sekarang",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
