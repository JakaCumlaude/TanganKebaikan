import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Dummy Persis seperti di Gambar
    final List<Map<String, dynamic>> projects = [
      {
        "title": "Bantuan Korban Banjir Jakarta",
        "desc": "Proyek ini bertujuan untuk menyediakan makanan, pakaian, dan tempat tinggal sementara bagi ribuan korban banjir.",
        "image": "https://images.unsplash.com/photo-1547683905-f686c993aee5?w=500&q=80",
        "status": "Berjalan",
        "statusColor": Colors.blue,
        "statusTextColor": Colors.white
      },
      {
        "title": "Pembangunan Kembali Sekolah",
        "desc": "Membangun kembali fasilitas pendidikan yang hancur akibat gempa bumi di Palu.",
        "image": "https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=500&q=80",
        "status": "Berjalan",
        "statusColor": Colors.blue,
        "statusTextColor": Colors.white
      },
      {
        "title": "Distribusi Obat-obatan",
        "desc": "Menyediakan pasokan obat-obatan esensial dan layanan kesehatan gratis bagi masyarakat pengungsi.",
        "image": "https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=500&q=80",
        "status": "Berjalan",
        "statusColor": Colors.blue,
        "statusTextColor": Colors.white
      },
      {
        "title": "Rehabilitasi Lingkungan",
        "desc": "Proyek reforestasi dan pemulihan ekosistem di area yang terdampak kebakaran hutan besar.",
        "image": "https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=500&q=80",
        "status": "Selesai",
        "statusColor": Colors.white, // Background putih
        "statusTextColor": Colors.black // Teks hitam
      },
      {
        "title": "Bantuan Nutrisi Anak",
        "desc": "Memberikan bantuan nutrisi berupa makanan bergizi dan suplemen vitamin untuk anak-anak.",
        "image": "https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=500&q=80",
        "status": "Berjalan", // Di gambar ada tombol 'Daftar Volunteer' tapi kita samakan dulu strukturnya
        "statusColor": Colors.blue,
        "statusTextColor": Colors.white
      },
      {
        "title": "Penyediaan Air Bersih",
        "desc": "Membangun sumur bor dan fasilitas penampungan air bersih untuk masyarakat desa kering.",
        "image": "https://images.unsplash.com/photo-1584973757149-75c710180727?w=500&q=80",
        "status": "Selesai",
        "statusColor": Colors.white,
        "statusTextColor": Colors.black
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        // Judul Halaman
        title: Text("Daftar Proyek Bantuan", style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Deskripsi Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                "Temukan berbagai proyek bantuan yang sedang berjalan dan jadilah bagian dari perubahan positif.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13, height: 1.5),
              ),
            ),

            const SizedBox(height: 16),

            // Tombol Biru Besar "Daftarkan project bantuan anda disini"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/create-project'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3), // Biru terang
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: Text(
                    "Daftarkan project bantuan anda disini",
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Grid Proyek (2 Kolom di Desktop/Tablet, 1 Kolom di HP Kecil agar rapi)
            // Menggunakan LayoutBuilder agar responsif, tapi defaultnya kita buat mirip grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.builder(
                shrinkWrap: true, // Agar bisa discroll di dalam SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Scroll ikut parent
                itemCount: projects.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 Kolom seperti di gambar
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.65, // Mengatur tinggi kartu agar pas (gambar + teks + tombol)
                ),
                itemBuilder: (context, index) {
                  final item = projects[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      // Shadow tipis seperti di gambar
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                      ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar + Badge Status
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.network(
                                item['image'],
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: item['statusColor'],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    if(item['status'] == 'Selesai') // Shadow khusus untuk badge putih
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
                                  ]
                                ),
                                child: Text(
                                  item['status'],
                                  style: GoogleFonts.inter(
                                    color: item['statusTextColor'], 
                                    fontSize: 10, 
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        
                        // Konten Teks
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14, height: 1.2),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['desc'],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 11, height: 1.4),
                                ),
                                const Spacer(), // Dorong tombol ke bawah
                                
                                // Tombol Detail Proyek (Outline Button)
                                SizedBox(
                                  width: double.infinity,
                                  height: 36,
                                  child: OutlinedButton(
                                    onPressed: () => Navigator.pushNamed(context, '/project-detail'),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.grey.shade300),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      padding: EdgeInsets.zero
                                    ),
                                    child: Text(
                                      "Detail Proyek",
                                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}