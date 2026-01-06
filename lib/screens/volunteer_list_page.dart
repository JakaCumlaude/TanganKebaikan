import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/volunteer_card.dart';
import '../models/volunteer_model.dart'; // Pastikan model sudah dibuat
import 'volunteer_detail_page.dart';

class VolunteerListPage extends StatefulWidget {
  const VolunteerListPage({super.key});

  @override
  State<VolunteerListPage> createState() => _VolunteerListPageState();
}

class _VolunteerListPageState extends State<VolunteerListPage> {
  final Color primaryBlue = const Color(0xFF4A90E2);
  
  // URL MockAPI kamu
  final String newsUrl = "https://newsapi.org/v2/everything?q=relawan&apiKey=6c3bf1b69852470e87c5ec8807d56115";
  final String mockUrl = "https://694d37b1ad0f8c8e6e200fe8.mockapi.io/volunteers";

  // Fungsi GET Data
  Future<List<Volunteer>> fetchVolunteers() async {
  try {
    // 1. Panggil kedua API secara bersamaan
    final newsResponse = await http.get(Uri.parse(newsUrl));
    final mockResponse = await http.get(Uri.parse(mockUrl));

    List<Volunteer> combinedList = [];

    // 2. Proses data dari NewsAPI (jika berhasil)
    if (newsResponse.statusCode == 200) {
      Map<String, dynamic> newsData = json.decode(newsResponse.body);
      List articles = newsData['articles'];
      combinedList.addAll(articles.map((json) => Volunteer.fromJson(json)).toList());
    }

    // 3. Proses data dari MockAPI (data pendaftaranmu)
    if (mockResponse.statusCode == 200) {
      List mockData = json.decode(mockResponse.body);
      // Data MockAPI biasanya berupa List langsung
      combinedList.addAll(mockData.map((json) => Volunteer.fromJson(json)).toList());
    }

    return combinedList;
  } catch (e) {
    throw Exception('Gagal memuat data relawan: $e');
  }
}

  // Fungsi DELETE Data (Method ke-2 sesuai syarat tugas)
  Future<void> deleteVolunteer(String id) async {
    final response = await http.delete(Uri.parse("$mockUrl/$id"));
    if (response.statusCode == 200) {
      setState(() {}); // Refresh tampilan setelah hapus
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data relawan berhasil dihapus")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: CustomScrollView(
        slivers: [
          // Header (Tetap sama)
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 100.0,
            pinned: true,
            elevation: 0,
            backgroundColor: primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 12),
              centerTitle: false,
              title: const Text(
                "Temukan Peluang Relawan",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
              ),
              background: Container(color: primaryBlue),
            ),
          ),

          // Search Bar & Filter (Tetap sama)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  const Text("Pilih Berdasarkan Minat", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildCategoryList(),
                ],
              ),
            ),
          ),

          // DAFTAR PROGRAM (Dihubungkan ke API)
          FutureBuilder<List<Volunteer>>(
            future: fetchVolunteers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(child: Text("Error: ${snapshot.error}")),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text("Tidak ada data relawan")),
                );
              }

              // Jika data ada, tampilkan ListView lewat SliverList
              return SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = snapshot.data![index];
                      return Dismissible(
                        key: Key(item.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => deleteVolunteer(item.id),
                        child: VolunteerCard(
                          name: item.name, 
                          city: item.city,
                          imageUrl: item.imageUrl,
                          needed: item.needed,
                          onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VolunteerDetailPage(volunteer: item),
      ),
    );
  },
                        ),
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                ),
              );
            },
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  // --- Helper Widgets agar kode bersih ---
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Cari kegiatan...",
          prefixIcon: Icon(Icons.search, color: primaryBlue),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryChip("Semua", true),
          _buildCategoryChip("Pendidikan", false),
          _buildCategoryChip("Lingkungan", false),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {},
        selectedColor: primaryBlue,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
      ),
    );
  }
}