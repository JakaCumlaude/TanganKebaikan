import 'package:flutter/material.dart';
import '../../models/activity_history_model.dart';

class ActivityDetailPage extends StatelessWidget {
  final ActivityHistory activity;

  const ActivityDetailPage({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Kegiatan")),
      body: ListView(
        children: [
          Image.network(
            activity.image,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14),
                    const SizedBox(width: 6),
                    Text(activity.date),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: Colors.red),
                    const SizedBox(width: 6),
                    Text(activity.location),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Deskripsi",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(activity.description),
              ],
            ),
          )
        ],
      ),
    );
  }
}
