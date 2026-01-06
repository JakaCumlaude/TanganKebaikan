import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/profile_model.dart';
import '../home/splash_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color primaryBlue = const Color(0xFF4A90E2);
  late Future<Profile> _profileFuture;

  final String apiUrl =
      "https://6950dbe970e1605a1088a896.mockapi.io/profile/1";

  @override
  void initState() {
    super.initState();
    _profileFuture = fetchProfile(); // ✅ DIPANGGIL SEKALI
  }

  Future<Profile> fetchProfile() async {
  final res = await http.get(
    Uri.parse("https://6950dbe970e1605a1088a896.mockapi.io/profile"),
  );

  if (res.statusCode == 200) {
    final List data = json.decode(res.body);

    if (data.isEmpty) {
      throw Exception("Data profil kosong");
    }

    return Profile.fromJson(data.first); // 🔥 AMAN
  } else {
    throw Exception("Gagal memuat profil");
  }
}


  Future<void> updateProfile(String name, String role) async {
    await http.put(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": name,
        "role": role,
      }),
    );
    setState(() {
      _profileFuture = fetchProfile(); // 🔄 refresh setelah edit
    });
  }

  void showEditDialog(Profile profile) {
    final nameController = TextEditingController(text: profile.name);
    final roleController = TextEditingController(text: profile.role);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Profil"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: "Peran"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              await updateProfile(
                nameController.text,
                roleController.text,
              );
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: FutureBuilder<Profile>(
         future: _profileFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(child: Text(snapshot.error.toString()));
    }

          final profile = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileHeader(profile),
                _buildStatCards(profile),
                _buildProfileMenu(
                  Icons.edit,
                  "Edit Profil",
                  () => showEditDialog(profile),
                ),
                _buildProfileMenu(
                  Icons.volunteer_activism,
                  "Riwayat Kegiatan",
                  () => Navigator.pushNamed(context, '/activity-history'),
                ),
                const Divider(),
                _buildProfileMenu(
                  Icons.logout,
                  "Keluar",
                  () => _showLogoutDialog(context),
                  isLogout: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(Profile profile) {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 60),
          ),
          const SizedBox(height: 15),
          Text(
            profile.name,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            profile.role,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCards(Profile p) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          _statItem(p.donation.toString(), "Donasi"),
          _statItem(p.volunteer.toString(), "Relawan"),
          _statItem(p.points.toString(), "Poin"),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue)),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildProfileMenu(
      IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : primaryBlue),
      title: Text(title,
          style:
              TextStyle(color: isLogout ? Colors.red : Colors.black)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi Keluar"),
        content: const Text("Yakin ingin keluar?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal")),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SplashScreen()),
                (_) => false,
              );
            },
            child: const Text("Keluar"),
          ),
        ],
      ),
    );
  }
}
