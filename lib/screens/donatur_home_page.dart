import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'gallery_hub_page.dart'; 
import 'volunteer_list_page.dart';
import 'profile_page.dart';
import 'project_registration_page.dart';

// Menambahkan 'project' ke dalam Enum
enum MenuTab { home, gallery, project, volunteer, profile }

class DonaturHomePage extends StatefulWidget {
  const DonaturHomePage({super.key});

  @override
  State<DonaturHomePage> createState() => _DonaturHomePageState();
}

class _DonaturHomePageState extends State<DonaturHomePage> {
  MenuTab _selectedTab = MenuTab.home;
  bool _showGreeting = true; 
  
  // Endpoint MockAPI untuk Proyek
  final String mockProjectUrl = "https://694d37b1ad0f8c8e6e200fe8.mockapi.io/projects";
  
  final Color primaryBlue = const Color(0xFF4A90E2);
  final Color secondaryGreen = const Color(0xFF50E3C2);
  final Color lightGrey = const Color(0xFFF5F5F5);

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showGreeting = false);
    });
  }

  // --- HTTP METHODS (GET & DELETE) ---
  Future<List<dynamic>> fetchProjects() async {
    try {
      final response = await http.get(Uri.parse(mockProjectUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      debugPrint("Error Fetch: $e");
    }
    return [];
  }

  Future<void> deleteProject(String id) async {
    try {
      final response = await http.delete(Uri.parse("$mockProjectUrl/$id"));
      if (response.statusCode == 200) {
        setState(() {}); // Refresh UI setelah hapus
      }
    } catch (e) {
      debugPrint("Error Delete: $e");
    }
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      // Navigasi ke Halaman Registrasi Proyek (POST)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectRegistrationPage()),
      ).then((_) => setState(() {})); // Refresh Home saat kembali
    } else {
      setState(() {
        _selectedTab = MenuTab.values[index];
      });
    }
  }

  Widget _buildSelectedBody() {
    switch (_selectedTab) {
      case MenuTab.home: return _buildHomeContent(); 
      case MenuTab.gallery: return const GalleryHubPage(); 
      case MenuTab.volunteer: return const VolunteerListPage();
      case MenuTab.profile: return const ProfilePage();
      default: return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildSelectedBody(), 
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHomeContent() {
    return CustomScrollView(
      slivers: [
        _buildHeader(),
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(height: 20),
            _buildImpactMetrics(),
            const SizedBox(height: 24),
            _buildQuickAccessButtons(),
            const SizedBox(height: 30),
            const Divider(color: Color(0xFFE0E0E0), thickness: 8),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daftar Proyek Bantuan Anda',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Geser ke kiri untuk membatalkan pengajuan',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  _buildProjectList(), // Menggantikan Campaign Terpopuler
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildProjectList() {
  return FutureBuilder<List<dynamic>>(
    future: fetchProjects(), // Fungsi GET dari MockAPI
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      
      if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("Belum ada proyek bantuan."));
      }

      return SizedBox(
        height: 320, 
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final item = snapshot.data![index];
            
            // Proteksi agar tidak error 'Null is not a subtype of String'
            String title = item['title']?.toString() ?? "Judul tidak tersedia";
            String desc = item['description']?.toString() ?? "Tidak ada deskripsi";
            String status = item['status']?.toString() ?? "Berjalan";
            String id = item['id']?.toString() ?? index.toString();

            return Container(
              width: 220,
              margin: const EdgeInsets.only(right: 16),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bagian Gambar & Status
                    Stack(
                      children: [
                        Container(
              height: 130,
              width: double.infinity,
              child: Image.network(
                // Mengambil URL dari field 'image' di MockAPI
                // Jika null, akan menggunakan gambar placeholder
                item['image'] ?? "https://via.placeholder.com/200x130?text=No+Image",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Jika URL gambar rusak/error, tampilkan icon ini
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: status == "Berjalan" ? Colors.blue : Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              status,
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Bagian Teks Detail
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            desc,
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.blue),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text("Detail Proyek", style: TextStyle(fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

  // --- Widget Header & Navigasi ---
  SliverAppBar _buildHeader() {
    return SliverAppBar(
      backgroundColor: primaryBlue,
      expandedHeight: 80,
      pinned: true,
      automaticallyImplyLeading: false,
      title: Text(_showGreeting ? "Halo, Pahlawan!" : "Beranda", style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: 'Galeri'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle, size: 40, color: Color(0xFF4A90E2)), 
          label: 'Ajukan Proyek'
        ),
        BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: 'Volunteer'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
      currentIndex: _selectedTab.index,
      selectedItemColor: primaryBlue,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
    );
  }

  // Widget dummy lainnya tetap ada (Metrics, QuickAccess)
  Widget _buildImpactMetrics() { return Container(); } // Sederhanakan untuk contoh
  Widget _buildQuickAccessButtons() { return Container(); }
}