import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
             const Icon(Icons.volunteer_activism, color: Colors.blue),
             const SizedBox(width: 8),
             Text("Tangan Kebaikan", style: GoogleFonts.inter(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        actions: [
           Padding(
             padding: const EdgeInsets.only(right: 16), 
             child: CircleAvatar(
               backgroundColor: Colors.grey[200],
               backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=12'),
             )
           ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= 1. HERO SECTION (Banner) =================
            Container(
              width: double.infinity,
              color: const Color(0xFFE3F2FD), 
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/banjir.jpeg',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(height: 200, color: Colors.grey[300]),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bencana Banjir\nMelanda Sumatra!", 
                        style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: const Color(0xFF212121), height: 1.2)
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Bencana banjir besar melanda wilayah Sumatra. Ribuan keluarga membutuhkan bantuan makanan dan pakaian.", 
                        style: GoogleFonts.inter(color: Colors.grey[700], height: 1.5)
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/projects'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("Bantu Sekarang", style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white)),
                      )
                    ],
                  )
                ],
              ),
            ),

            // ================= 2. MENU GRID =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                children: [
                  Expanded(child: _buildMenuCard(context, Icons.inventory_2_outlined, "Proyek Bantuan", '/projects')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildMenuCard(context, Icons.handshake_outlined, "Daftar Volunteer", '/volunteer')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildMenuCard(context, Icons.photo_library_outlined, "Galeri History", '/gallery')),
                ],
              ),
            ),

            // ================= 3. VOLUNTEER SECTION (Horizontal Scroll) =================
            // --- UPDATE: Dibuat menyamping (horizontal) agar lebih ringkas ---
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Volunteer", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
                      TextButton(onPressed: () => Navigator.pushNamed(context, '/volunteer'), child: const Text("Lihat Semua")),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 240, // Tinggi area scroll
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildCompactVolunteerCard(
                        "Bantuan Banjir",
                        "Logistik & Medis",
                        "assets/images/vounter1.jpg"
                      ),
                      const SizedBox(width: 16),
                      _buildCompactVolunteerCard(
                        "Posko Kesehatan",
                        "Medis & Trauma Healing",
                        "assets/images/volunter2.jpg"
                      ),
                      const SizedBox(width: 16),
                      _buildCompactVolunteerCard(
                        "Dapur Umum",
                        "Memasak & Distribusi",
                        "https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=500&q=80"
                      ),
                    ],
                  ),
                ),
              ],
            ),

             // ================= 4. SOSIALISASI SECTION =================
            Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.symmetric(vertical: 30),
              color: const Color(0xFFFAFAFA),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "SOSIALISASI KAMI", 
                      textAlign: TextAlign.center, 
                      style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 240,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildSocialCard("Kunjungan Panti", "12 Okt 2023", "assets/images/pantianak.jpg"),
                        const SizedBox(width: 16),
                        _buildSocialCard("Edukasi Bencana", "15 Nov 2023", "assets/images/pantijompo.jpg"),
                        const SizedBox(width: 16),
                         _buildSocialCard("Posyandu Keliling", "02 Des 2023", "assets/images/pantidisabilitas.jpg"),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // ================= 5. FOOTER / CONTACT =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Informasi Kontak", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildContactItem(Icons.email_outlined, "Email", "help@tangankebaikan.org"),
                  _buildContactItem(Icons.phone_outlined, "Telepon", "+62 812 3456 7890"),
                  _buildContactItem(Icons.location_on_outlined, "Alamat", "Jl. Sudirman No. 1, Jakarta"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildMenuCard(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              label, 
              textAlign: TextAlign.center, 
              style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87)
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BARU: Kartu Volunteer yang Lebih Kecil (Compact) ---
  Widget _buildCompactVolunteerCard(String title, String role, String imgUrl) {
    return Container(
      width: 200, // Lebar tetap agar seragam
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imgUrl, 
              height: 120, // Gambar lebih pendek
              width: double.infinity, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(height: 120, color: Colors.grey[200]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(role, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: (){},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      visualDensity: VisualDensity.compact,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
                    ),
                    child: Text("Daftar", style: GoogleFonts.inter(fontSize: 12, color: Colors.blue)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSocialCard(String title, String date, String imgUrl) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imgUrl, 
                width: double.infinity, 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(date, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(value, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700])),
            ],
          )
        ],
      ),
    );
  }
}