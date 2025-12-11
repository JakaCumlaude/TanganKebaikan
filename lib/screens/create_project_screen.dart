import 'package:flutter/material.dart';

class CreateProjectScreen extends StatelessWidget {
  const CreateProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajukan Proyek")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Isi Detail Proyek", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextFormField(decoration: const InputDecoration(labelText: "Nama Pemohon")),
            const SizedBox(height: 16),
            TextFormField(decoration: const InputDecoration(labelText: "Judul Project")),
            const SizedBox(height: 16),
            TextFormField(maxLines: 4, decoration: const InputDecoration(labelText: "Deskripsi Project", alignLabelWithHint: true)),
            const SizedBox(height: 16),
            TextFormField(keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Target Donasi (Rp)")),
            const SizedBox(height: 20),
            const Text("Unggah Foto Bukti", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 60,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Container(padding: const EdgeInsets.all(16), color: Colors.grey[200], child: const Icon(Icons.upload_file, color: Colors.grey)),
                  const SizedBox(width: 16),
                  const Text("Belum ada file dipilih", style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Proyek Diajukan!")));
                  Navigator.pop(context);
                },
                child: const Text("Kirim Permohonan"),
              ),
            )
          ],
        ),
      ),
    );
  }
}