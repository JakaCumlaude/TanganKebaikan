import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Menggunakan SingleChildScrollView agar seluruh halaman bisa di-scroll
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================== 1. NAVBAR ==================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Row(
                    children: [
                      const Icon(Icons.volunteer_activism, color: Colors.blue, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        "TanganKebaikan",
                        style: GoogleFonts.inter(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          color: const Color(0xFF2196F3)
                        ),
                      ),
                    ],
                  ),
                  // Menu Login/Register (Responsive: disembunyikan di layar kecil jika perlu)
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        child: Text("Masuk", style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.grey[800])),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/register'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("Daftar", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // ================== 2. HERO SECTION ==================
            Container(
              width: double.infinity,
              // Background image dengan overlay putih transparan agar teks terbaca
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=1000'), // Gambar placeholder mirip desain
                  fit: BoxFit.cover,
                  opacity: 0.15, // Membuat gambar agak transparan
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      "Ulurkan Tangan,\nBeri Harapan.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF212121),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Melalui platform Donasi Sosial, Anda dapat terhubung langsung\ndengan mereka yang membutuhkan.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[700], height: 1.5),
                    ),
                    const SizedBox(height: 32),
                    
                    // --- PERBAIKAN TOMBOL ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/login'),
                          // PERBAIKAN: Padding dimasukkan ke styleFrom
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text("Donasi Sekarang", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blue),
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text("Pelajari Lebih Lanjut", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ================== 3. TUJUAN PROGRAM (FEATURES) ==================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                children: [
                  Text("Tujuan Program Kami", style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(
                    "Kami fokus pada beberapa pilar utama untuk memastikan bantuan tepat sasaran.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 40),
                  // Grid Menu
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildFeatureCard(Icons.favorite_border, "Kesejahteraan", "Dukungan esensial untuk hidup."),
                      _buildFeatureCard(Icons.school_outlined, "Edukasi", "Akses pendidikan berkualitas."),
                      _buildFeatureCard(Icons.people_outline, "Komunitas", "Membangun kemandirian warga."),
                      _buildFeatureCard(Icons.verified_outlined, "Transparansi", "Laporan terbuka dan jujur."),
                    ],
                  ),
                ],
              ),
            ),

            // ================== 4. TESTIMONIALS ==================
            Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
              child: Column(
                children: [
                  Text("Apa Kata Mereka?", style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildTestimonialCard("Siti Rahayu", "Donasi ini sangat membantu keluarga kami saat banjir."),
                        const SizedBox(width: 16),
                        _buildTestimonialCard("Budi Santoso", "Sangat transparan, saya tahu kemana uang saya pergi."),
                        const SizedBox(width: 16),
                        _buildTestimonialCard("Kartika Dewi", "Mudah digunakan dan respon tim sangat cepat."),
                        const SizedBox(width: 16),
                        _buildTestimonialCard("Dewi Sari", "Tim baik dan respon tim sangat cepat."),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // ================== 5. FOOTER CTA ==================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              color: Colors.white,
              child: Column(
                children: [
                  Text("Siap Membuat Perbedaan?", style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                    child: const Text("Daftar Sekarang", style: TextStyle(color: Colors.white, fontSize: 16)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Kartu Fitur (Tujuan Program)
  Widget _buildFeatureCard(IconData icon, String title, String desc) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 12),
          Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(desc, style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 12, height: 1.5)),
        ],
      ),
    );
  }

  // Widget Helper untuk Kartu Testimoni
  Widget _buildTestimonialCard(String name, String comment) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('"$comment"', style: GoogleFonts.inter(fontStyle: FontStyle.italic, color: Colors.grey[700], height: 1.5)),
          const Spacer(),
          Row(
            children: [
              const CircleAvatar(backgroundColor: Colors.grey, radius: 16, child: Icon(Icons.person, color: Colors.white, size: 16)),
              const SizedBox(width: 10),
              Text(name, style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}