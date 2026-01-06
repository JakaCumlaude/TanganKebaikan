import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/volunteer_card.dart';
import '../../models/volunteer_model.dart';
import 'volunteer_detail_page.dart';

class VolunteerListPage extends StatefulWidget {
  const VolunteerListPage({super.key});

  @override
  State<VolunteerListPage> createState() => _VolunteerListPageState();
}

class _VolunteerListPageState extends State<VolunteerListPage> {
  final Color primaryBlue = const Color(0xFF4A90E2);

  final String mockUrl =
      "https://694d37b1ad0f8c8e6e200fe8.mockapi.io/volunteers";

  // GET
  Future<List<Volunteer>> fetchVolunteers() async {
    final response = await http.get(Uri.parse(mockUrl));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Volunteer.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat data volunteer");
    }
  }

  // DELETE + ALERT
  Future<void> deleteVolunteer(String id) async {
    final response = await http.delete(Uri.parse("$mockUrl/$id"));
    if (response.statusCode == 200) {
      setState(() {});

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Berhasil"),
          content: const Text("Data relawan berhasil dihapus"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: CustomScrollView(
        slivers: [
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              background: Container(color: primaryBlue),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  const Text(
                    "Pilih Berdasarkan Minat",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildCategoryList(),
                ],
              ),
            ),
          ),

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
                          child:
                              const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => deleteVolunteer(item.id),
                        child: VolunteerCard(
  name: item.name,
  city: item.location,
  imageUrl: item.image,
  needed: 30,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VolunteerDetailPage(volunteer: item),
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

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
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
        onSelected: (_) {},
        selectedColor: primaryBlue,
        checkmarkColor: Colors.white,
        labelStyle:
            TextStyle(color: isSelected ? Colors.white : Colors.black87),
      ),
    );
  }
}
