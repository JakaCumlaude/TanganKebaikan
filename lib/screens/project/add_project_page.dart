import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final titleC = TextEditingController();
  final descC = TextEditingController();
  final targetC = TextEditingController();

  Future<void> submitProject() async {
    await http.post(
      Uri.parse("https://694d37b1ad0f8c8e6e200fe8.mockapi.io/projects"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "title": titleC.text,
        "description": descC.text,
        "target": targetC.text,
        "status": "Menunggu",
      }),
    );

    // 🔥 ALERT DIALOG
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Berhasil"),
        content: const Text("Project bantuan berhasil diajukan"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajukan Project")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(labelText: "Judul Project"),
            ),
            TextField(
              controller: descC,
              decoration: const InputDecoration(labelText: "Deskripsi"),
            ),
            TextField(
              controller: targetC,
              decoration: const InputDecoration(labelText: "Target Dana"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitProject,
              child: const Text("Kirim Project"),
            )
          ],
        ),
      ),
    );
  }
}
