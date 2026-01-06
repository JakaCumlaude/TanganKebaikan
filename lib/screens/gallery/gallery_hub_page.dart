import 'package:flutter/material.dart';
import 'gallery_detail_page.dart'; 

class GalleryHubPage extends StatelessWidget {
  const GalleryHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi warna agar seragam dengan halaman utama
    const Color primaryBlue = Color(0xFF4A90E2);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // Menggunakan NestedScrollView agar TabBar bisa ikut scrolling dengan SliverAppBar
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                // Menghapus tombol back otomatis sesuai permintaan
                automaticallyImplyLeading: false, 
                backgroundColor: primaryBlue,
                // Tinggi disamakan dengan header DonaturHomePage (100.0)
                expandedHeight: 100.0, 
                pinned: true,
                elevation: 0,
                flexibleSpace: const FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 20, bottom: 62),
                  centerTitle: false,
                  title: Text(
                    'Galeri Kebaikan',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white
                    ),
                  ),
                ),
                // TabBar diletakkan di bagian bottom SliverAppBar
                bottom: const TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 3,
                  labelColor: Colors.white, // Warna teks tab yang dipilih menjadi putih
                  unselectedLabelColor: Colors.white70, // Warna teks tab yang tidak dipilih (putih transparan)
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: 'Semua'),
                    Tab(text: 'Proyek Saya'),
                    Tab(text: 'Terdekat'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildGalleryGrid(context),
              const Center(child: Text('Proyek yang Anda bantu akan muncul di sini')),
              const Center(child: Text('Proyek di sekitar lokasi Anda')),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
             // Aksi untuk berbagi dampak
          },
          backgroundColor: primaryBlue,
          icon: const Icon(Icons.share, color: Colors.white),
          label: const Text(
            'Bagikan Dampak (+10 Poin)', 
            style: TextStyle(color: Colors.white)
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigasi ke halaman detail
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const GalleryDetailPage())
            );
          },
          child: Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      'https://via.placeholder.com/200', 
                      height: 120, 
                      width: double.infinity, 
                      fit: BoxFit.cover
                    ),
                    Positioned( 
                      top: 8, 
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green, 
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Text(
                          '✅ Selesai', 
                          style: TextStyle(color: Colors.white, fontSize: 10)
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pembangunan Sumur A', 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.favorite, size: 14, color: Colors.red),
                          SizedBox(width: 4),
                          Text(
                            '1.2rb Reaksi', 
                            style: TextStyle(fontSize: 11, color: Colors.grey)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}