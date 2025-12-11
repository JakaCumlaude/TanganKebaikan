import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text("Detail Proyek", style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= 1. GAMBAR UTAMA & GALERI =================
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1547683905-f686c993aee5?w=800',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Galeri Mini (4 Gambar)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:List.generate(4, (index) => 
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=200&q=80', // Gambar dummy anak-anak
                          width: 80,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),

            // ================= 2. JUDUL & STATUS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Penyaluran Bantuan Korban Banjir Bandang",
                          style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, height: 1.2),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(4)),
                          child: Text("Berjalan", style: GoogleFonts.inter(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Kotak Info Singkat di Kanan (Opsional, sesuai gambar layout kolom kanan)
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Target Donasi", style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
                        Text("Rp 100 Juta", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, '/donation'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
                            ),
                            child: Text("Donasi Sekarang", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ================= 3. TENTANG PROYEK =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tentang Proyek Ini", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text(
                    "Banjir bandang yang melanda Kabupaten Bogor telah menyebabkan ribuan warga kehilangan tempat tinggal dan harta benda. Banyak akses jalan terputus, mempersulit proses evakuasi dan distribusi bantuan.\n\nBantuBencana hadir untuk mengkoordinasikan upaya penyaluran bantuan esensial, mulai dari logistik makanan, air minum bersih, hingga pendampingan psikososial bagi anak-anak dan keluarga. Tahap pertama fokus pada evakuasi dan penyelamatan korban.",
                    style: GoogleFonts.inter(fontSize: 14, height: 1.6, color: Colors.grey[800]),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ================= 4. SECTION KONTAK ADMIN =================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB), // Abu-abu sangat muda
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Text("Ada Pertanyaan Lebih Lanjut?", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(
                    "Jika Anda memiliki pertanyaan spesifik mengenai proyek ini atau ingin berkolaborasi, jangan ragu untuk menghubungi tim administrasi kami.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600], height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton(
                    onPressed: (){},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                    ),
                    child: Text("Hubungi Admin", style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.blue)),
                  )
                ],
              ),
            ),

            const SizedBox(height: 60),

            // ================= 5. FOOTER (Hitam/Gelap) =================
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