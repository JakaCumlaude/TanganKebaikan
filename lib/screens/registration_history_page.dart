import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationHistoryPage extends StatefulWidget {
  const RegistrationHistoryPage({super.key});

  @override
  State<RegistrationHistoryPage> createState() => _RegistrationHistoryPageState();
}

class _RegistrationHistoryPageState extends State<RegistrationHistoryPage> {
  final String volunteerUrl = "https://694d37b1ad0f8c8e6e200fe8.mockapi.io/volunteers";

  Future<List<dynamic>> fetchHistory() async {
    final response = await http.get(Uri.parse(volunteerUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pendaftaran"),
        backgroundColor: const Color(0xFF4A90E2),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada riwayat pendaftaran."));
          }

          // Menampilkan data lewat List View sesuai syarat tugas
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.person_outline, color: Color(0xFF4A90E2)),
                  title: Text(data['name'] ?? "Anonim", style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Alasan: ${data['city']}"), // Menggunakan field city sebagai alasan
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),
              );
            },
          );
        },
      ),
    );
  }
}