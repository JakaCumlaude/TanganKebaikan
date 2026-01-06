import 'package:flutter/material.dart';

class VolunteerCard extends StatelessWidget {
  final String name;
  final String city;
  final String imageUrl;
  final int needed;
  final VoidCallback onTap;

  const VolunteerCard({
    super.key,
    required this.name,
    required this.city,
    required this.imageUrl,
    required this.needed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(city,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dibutuhkan: $needed Orang"),
                    ElevatedButton(
                      onPressed: onTap,
                      child: const Text("Lihat Detail"),
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
