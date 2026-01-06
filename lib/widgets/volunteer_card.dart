import 'package:flutter/material.dart';

class VolunteerCard extends StatelessWidget {
  final String name;
  final String city;
  final String imageUrl;
  final int needed;
  final VoidCallback onTap; // TAMBAHKAN INI: Untuk menangkap aksi klik

  const VolunteerCard({
    super.key,
    required this.name,
    required this.city,
    required this.imageUrl,
    required this.needed,
    required this.onTap, // TAMBAHKAN INI: Wajib diisi saat memanggil kartu
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              color: Colors.grey.shade200,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.red),
                    Text(" $city", style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dibutuhkan: $needed Orang"),
                    ElevatedButton(
                      // UBAH DI SINI: Gunakan parameter onTap yang sudah dibuat
                      onPressed: onTap, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                      ),
                      child: const Text("Lihat Detail", style: TextStyle(color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}