import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/volunteer_model.dart';

class VolunteerDetailPage extends StatelessWidget {
  final Volunteer volunteer;

  const VolunteerDetailPage({super.key, required this.volunteer});

  Future<void> openLink() async {
    final uri = Uri.parse(volunteer.registrationLink);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Tidak bisa membuka link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Volunteer")),
      body: ListView(
        children: [
          Image.network(
            volunteer.image,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(volunteer.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(width: 6),
                    Text(volunteer.location),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Deskripsi",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(volunteer.description),
                const SizedBox(height: 20),

                // 🔥 LINK (BUKAN BUTTON — SESUAI TUGAS)
                GestureDetector(
                  onTap: openLink,
                  child: Text(
                    volunteer.registrationLink,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
