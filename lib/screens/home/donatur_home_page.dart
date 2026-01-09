import 'dart:async';
import 'package:flutter/material.dart';
import '../../api_service.dart';
import '../../models/project_model.dart';
import '../project/project_list_screen.dart';
import '../gallery/gallery_hub_page.dart';
import '../volunteer/volunteer_list_page.dart';
import '../profile/profile_page.dart';

enum MenuTab { home, gallery, project, volunteer, profile }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuTab _selectedTab = MenuTab.home;
  bool _showGreeting = true;

  final Color primaryBlue = const Color(0xFF4A90E2);

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showGreeting = false);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedTab = MenuTab.values[index];
    });
  }

  Widget _buildSelectedBody() {
    switch (_selectedTab) {
      case MenuTab.home:
        return _buildHomeContent();
      case MenuTab.gallery:
        return const GalleryHubPage();
      case MenuTab.project:
        return const ProjectListScreen();
      case MenuTab.volunteer:
        return const VolunteerListPage();
      case MenuTab.profile:
        return const ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSelectedBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  /* =========================
        HOME CONTENT
  ========================== */

  Widget _buildHomeContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 100,
          backgroundColor: primaryBlue,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(_showGreeting ? "Halo, Pahlawan!" : "Tangan Kebaikan"),
          ),
        ),

        // Statistik
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildSummaryStats(),
          ),
        ),

        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Proyek Bantuan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Grid Proyek
        _buildProjectGrid(),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  Widget _buildSummaryStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _StatItem("Rp 150M+", "Donasi"),
        _StatItem("1.240", "Proyek"),
        _StatItem("45rb", "Donatur"),
      ],
    );
  }

  Widget _buildProjectGrid() {
    return FutureBuilder<List<Project>>(
      future: ApiService.fetchProjects(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(child: Text("Error: ${snapshot.error}")),
          );
        }

        final projects = snapshot.data ?? [];

        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  _buildProjectCard(projects[index]),
              childCount: projects.length,
            ),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectCard(Project p) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              p.image,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: Colors.grey[300]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  p.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/project-detail',
                      arguments: p,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text("Detail", style: TextStyle(fontSize: 11)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedTab.index,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryBlue,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: 'Galeri'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Proyek'),
        BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism), label: 'Volunteer'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }
}

/* =========================
      WIDGET STAT ITEM
========================= */

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A90E2))),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
