import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GalleryDetailScreen extends StatelessWidget {
  const GalleryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        // Logo di kiri atas (Title kosong agar logo di leading/title)
        title: Row(
          children: [
             const Icon(Icons.volunteer_activism, color: Colors.blue),
             const SizedBox(width: 8),
             Text("tanganKebaikan", style: GoogleFonts.inter(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Text("Beranda", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
                const SizedBox(width: 16),
                Text("Sosialisasi", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= 1. HEADER SECTION (Abu-abu) =================
            Container(
              color: const Color(0xFFEBEFF3), // Abu-abu kebiruan
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kolom Teks Kiri
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Konferensi Inovasi\nDigital 2024",
                          style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF212121), height: 1.2),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text("17 - 19 Mei 2024", style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700])),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Konferensi Inovasi Digital 2024 adalah acara puncak yang mempertemukan para pemimpin industri, inovator teknologi, dan talenta muda untuk menjelajahi masa depan digital. Kami membahas tren terkini, teknologi disruptif, dan strategi transformatif.",
                          style: GoogleFonts.inter(fontSize: 13, height: 1.6, color: Colors.grey[800]),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Gambar Kanan
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=500', // Gambar anak-anak
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ================= 2. GALERI EVENT (Grid) =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Galeri Event", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  
                  // Grid Foto 2x3 (Total 6 foto seperti di gambar)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 Kolom
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.3, // Landscape ratio
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      // List URL gambar dummy yang berbeda-beda
                      final List<String> images = [
                        'https://images.unsplash.com/photo-1544027993-37dbfe43562a?w=400', // Orang diskusi
                        'https://images.unsplash.com/photo-1515187029135-18ee286d815b?w=400', // Panggung
                        'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?w=400', // Meeting
                        'https://images.unsplash.com/photo-1531482615713-2afd69097998?w=400', // Orang berdiri
                        'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=400', // Audience
                        'https://images.unsplash.com/photo-1560439514-e960a3ef5019?w=400', // Exhibition
                      ];
                      
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // ================= 3. SECTION CTA (Siap Membuat Perbedaan) =================
            Center(
              child: Column(
                children: [
                  Text("Siap Membuat Perbedaan?", style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/donation'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text("Donasi Sekarang", style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: (){}, 
                        child: Text("Tentang Kami", style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black87))
                      )
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 60),

            // ================= 4. FOOTER =================
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
                  const SizedBox(height: 12),
                  Text("Connecting hearts, changing lives. Your platform for impactful social donations.", style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600])),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("About Us", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
                            const SizedBox(height: 10),
                            _footerLink("Our Mission"),
                            _footerLink("How It Works"),
                            _footerLink("Team"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Support", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
                            const SizedBox(height: 10),
                            _footerLink("FAQ"),
                            _footerLink("Contact"),
                            _footerLink("Privacy Policy"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Get Involved", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
                            const SizedBox(height: 10),
                            _footerLink("Become a Donor"),
                            _footerLink("Request Aid"),
                            _footerLink("Campaigns"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(child: Text("© 2025 Donasi Sosial. All rights reserved.", style: GoogleFonts.inter(fontSize: 11, color: Colors.grey))),
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
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600])),
    );
  }
}