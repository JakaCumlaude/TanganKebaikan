import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProjectDetailPage extends StatefulWidget {
  final Map project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final String apiUrl =
      "https://694d37b1ad0f8c8e6e200fe8.mockapi.io/projects";

  bool isLoading = false;
  late String selectedStatus;

  final Map<String, String> statusMap = {
    "1": "Berjalan",
    "2": "Diterima",
    "3": "Ditolak",
    "4": "Selesai",
  };

  @override
  void initState() {
    super.initState();
    selectedStatus =
        statusMap[widget.project['status'].toString()] ?? "Berjalan";
  }

  Future<void> updateStatus() async {
    setState(() => isLoading = true);

    final response = await http.put(
      Uri.parse("$apiUrl/${widget.project['id']}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "status": statusMap.entries
            .firstWhere((e) => e.value == selectedStatus)
            .key,
      }),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      Navigator.pop(context, true);
    }
  }

  Future<void> deleteProject() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Project"),
        content: const Text("Yakin ingin menghapus project ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Hapus"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await http.delete(
      Uri.parse("$apiUrl/${widget.project['id']}"),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Project"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deleteProject,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project['title'] ?? "-",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(project['description'] ?? "-"),

            const SizedBox(height: 20),
            const Text("Status Project"),

            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              items: statusMap.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => selectedStatus = value!);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : updateStatus,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Update Status"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
