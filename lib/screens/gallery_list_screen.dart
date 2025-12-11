import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GalleryListScreen extends StatelessWidget {
  const GalleryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Dummy Sesuai Gambar
    final List<Map<String, String>> galleries = [
      {
        "title": "Rehabilitasi Gempa Cianjur",
        "date": "28 Februari 2024",
        "desc": "Bersama membangun kembali harapan, relawan bergotong royong memperbaiki rumah warga.",
        "image": "https://images.unsplash.com/photo-1584515933487-779824d29309?w=500"
      },
      {
        "title": "Air Bersih Kekeringan Boyolali",
        "date": "10 Maret 2024",
        "desc": "Penyaluran air bersih kepada masyarakat yang terdampak kekeringan di Boyolali.",
        "image": "https://images.unsplash.com/photo-1541252260730-0412e8e2108e?w=500"
      },
      {
        "title": "Pos Kesehatan Gunung Kidul",
        "date": "05 April 2024",
        "desc": "Layanan kesehatan gratis untuk warga terpencil di Gunung Kidul, menjangkau yang membutuhkan.",
        "image": "https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=500"
      },
      {
        "title": "Edukasi Anak Pengungsi",
        "date": "20 April 2024",
        "desc": "Memberikan semangat dan pendidikan bagi anak-anak di pengungsian, harapan masa depan.",
        "image": "https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=500"
      },
      {
        "title": "Distribusi Kebutuhan Pokok",
        "date": "10 Mei 2024",
        "desc": "Pengemasan dan distribusi kebutuhan pokok untuk daerah terdampak, cepat dan tepat sasaran.",
        "image": "https://images.unsplash.com/photo-1593113598332-cd288d649433?w=500"
      },
      {
        "title": "Pendampingan Lansia",
        "date": "25 Mei 2024",
        "desc": "Memberikan pendampingan dan dukungan moral bagi para lansia, memastikan mereka tidak sendiri.",
        "image": "https://images.unsplash.com/photo-1534349762913-96c220591187?w=500"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        // Judul Kosong di AppBar agar fokus ke konten body
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER TEXT ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Galeri Kegiatan Kami", style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF212121))),
                  const SizedBox(height: 16),
                  Text(
                    "Lihatlah momen-momen berharga dari berbagai proyek bantuan yang telah kami selesaikan. Setiap gambar dan video menceritakan kisah tentang harapan, ketahanan, dan semangat gotong royong.",
                    style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 14, height: 1.6),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),

            // --- GRID GALLERY ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.65, // Rasio kartu (tinggi/lebar)
                ),
                itemCount: galleries.length,
                itemBuilder: (context, index) {
                  final item = galleries[index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/gallery-detail'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar
                        Expanded(
                          flex: 5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item['image']!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Judul
                        Text(
                          item['title']!, 
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14, height: 1.2)
                        ),
                        const SizedBox(height: 4),
                        // Tanggal
                        Text(
                          item['date']!, 
                          style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 11)
                        ),
                        const SizedBox(height: 8),
                        // Deskripsi
                        Expanded(
                          flex: 3,
                          child: Text(
                            item['desc']!, 
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 11, height: 1.4)
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 60),

            // --- FOOTER ---
            Container(
              padding: const EdgeInsets.all(30),
              color: const Color(0xFFF8F9FA),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.volunteer_activism, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text("Tangan Kebaikan", style: GoogleFonts.inter(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Quick Links", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            _footerLink("Beranda"),
                            _footerLink("Proyek Bantuan"),
                            _footerLink("Informasi Volunteer"),
                            _footerLink("Galeri Kegiatan"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Support", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            _footerLink("Donasi"),
                            _footerLink("Daftar Volunteer"),
                            _footerLink("FAQ"),
                            _footerLink("Contact Us"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(child: Text("© 2025 BantuBencana. All rights reserved.", style: GoogleFonts.inter(fontSize: 12, color: Colors.grey))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _footerLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700])),
    );
  }
}