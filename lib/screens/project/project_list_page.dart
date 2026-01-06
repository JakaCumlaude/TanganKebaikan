import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/project_model.dart';
import 'project_detail_page.dart';
import 'add_project_page.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  late Future<List<Project>> futureProjects;

  final String apiUrl =
      "https://694d37b1ad0f8c8e6e200fe8.mockapi.io/projects";

  @override
  void initState() {
    super.initState();
    futureProjects = fetchProjects();
  }

  Future<List<Project>> fetchProjects() async {
    final res = await http.get(Uri.parse(apiUrl));

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => Project.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat project");
    }
  }

  void refreshData() {
    setState(() {
      futureProjects = fetchProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Bantuan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddProjectPage()),
              );
              refreshData(); // refresh setelah POST
            },
          )
        ],
      ),
      body: FutureBuilder<List<Project>>(
        future: futureProjects,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          final projects = snapshot.data!;

          if (projects.isEmpty) {
            return const Center(child: Text("Belum ada project"));
          }

          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, i) {
              final p = projects[i];
              return Card(
                child: ListTile(
                  title: Text(p.title),
                  subtitle: Text("Status: ${p.status}"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProjectDetailPage(project: p.toJson()),
                      ),
                    );

                    if (updated == true) {
                      refreshData(); // refresh setelah PUT
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
