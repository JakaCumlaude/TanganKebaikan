import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectRegistrationPage extends StatefulWidget {
  const ProjectRegistrationPage({super.key});

  @override
  State<ProjectRegistrationPage> createState() => _ProjectRegistrationPageState();
}

class _ProjectRegistrationPageState extends State<ProjectRegistrationPage> {
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _targetController = TextEditingController();

  final String mockUrl = "https://694d37b1ad0f8c8e6e200fe8.mockapi.io/projects";

  Future<void> _submit() async {
    final response = await http.post(
      Uri.parse(mockUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "applicant": _nameController.text,
        "title": _titleController.text,
        "description": _descController.text,
        "target": _targetController.text,
        "status": "Berjalan",
        "image": "https://link-gambar-dummy.com/foto.jpg"
      }),
    );
    if (response.statusCode == 201) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajukan Proyek"), leading: const BackButton()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Isi Detail Proyek", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _customTextField("Nama Pemohon", _nameController),
            _customTextField("Judul Project", _titleController),
            _customTextField("Deskripsi Project", _descController, maxLines: 4),
            _customTextField("Target Donasi (Rp)", _targetController, keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            const Text("Unggah Foto Bukti", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
              child: const Row(children: [Icon(Icons.file_upload_outlined), SizedBox(width: 10), Text("Belum ada file dipilih", style: TextStyle(color: Colors.grey))]),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A90E2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: _submit,
                child: const Text("Kirim Permohonan", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customTextField(String label, TextEditingController controller, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }
}