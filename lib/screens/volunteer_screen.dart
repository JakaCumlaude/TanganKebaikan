import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VolunteerScreen extends StatelessWidget {
  const VolunteerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih bersih
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        // Judul Kosong di AppBar agar fokus ke konten body
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            // --- HEADER TEXT ---
            Text("Daftar Volunteer", style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF212121))),
            const SizedBox(height: 12),
            Text(
              "Temukan berbagai proyek bantuan yang sedang berjalan dan jadilah bagian dari perubahan positif. Setiap aksi kecil Anda berarti besar bagi mereka yang membutuhkan.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 40),

            // --- GRID CARD VOLUNTEER ---
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 Kolom
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                childAspectRatio: 0.70, // Rasio tinggi/lebar kartu
              ),
              itemCount: 6, // Jumlah dummy item
              itemBuilder: (context, index) {
                return _buildVolunteerCard();
              },
            ),
            const SizedBox(height: 40), // Spasi bawah
          ],
        ),
      ),
    );
  }

  // --- WIDGET KARTU VOLUNTEER (Mirip Gambar) ---
  Widget _buildVolunteerCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Shadow sangat tipis agar elegan
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), 
            blurRadius: 10, 
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar di Atas
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              'https://images.unsplash.com/photo-1593113598332-cd288d649433?w=500', 
              height: 120, 
              width: double.infinity, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(height: 120, color: Colors.grey[200]),
            ),
          ),
          
          // Konten Teks
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bantuan Darurat Banjir Karawang", 
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, height: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Menyalurkan bantuan logistik dan medis untuk 500 keluarga terdampak banjir di Karawang.", 
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[600], height: 1.4),
                  ),
                  const Spacer(),
                  Text(
                    "Link : https://forms.gle/...", 
                    style: GoogleFonts.inter(fontSize: 10, color: Colors.blue[400]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}