import 'package:flutter/material.dart';
import '../../models/volunteer_model.dart';
import 'volunteer_detail_page.dart';

class VolunteerListPage extends StatelessWidget {
  const VolunteerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Volunteer> volunteers = [
      Volunteer(
        name: "Relawan Pendidikan",
        location: "Bandung",
        description:
            "Membantu kegiatan belajar anak-anak di daerah terpencil untuk meningkatkan kualitas pendidikan.",
        image:
            "https://images.unsplash.com/photo-1524178232363-1fb2b075b655",
        registrationLink: "https://forms.gle/abc", id: '',
      ),
      Volunteer(
        name: "Relawan Sosial",
        location: "Jakarta",
        description:
            "Aksi sosial dan kemanusiaan untuk membantu masyarakat kurang mampu.",
        image:
            "https://images.unsplash.com/photo-1509099836639-18ba1795216d",
        registrationLink: "https://forms.gle/def", id: '',
      ),
      Volunteer(
        name: "Relawan Lingkungan",
        location: "Surabaya",
        description:
            "Kegiatan bersih-bersih lingkungan serta penanaman pohon.",
        image:
            "https://images.unsplash.com/photo-1501004318641-b39e6451bec6",
        registrationLink: "https://forms.gle/ghi", id: '',
      ),
      Volunteer(
        name: "Relawan Kesehatan",
        location: "Yogyakarta",
        description:
            "Membantu pelayanan kesehatan masyarakat di daerah terpencil.",
        image:
            "https://images.unsplash.com/photo-1584515933487-779824d29309",
        registrationLink: "https://forms.gle/jkl", id: '',
      ),
      Volunteer(
        name: "Relawan Bencana",
        location: "Lombok",
        description:
            "Tanggap darurat bencana alam dan penyaluran bantuan kemanusiaan.",
        image:
            "https://images.unsplash.com/photo-1541976076758-347942db1970",
        registrationLink: "https://forms.gle/mno", id: '',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Volunteer"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: volunteers.length,
        itemBuilder: (context, index) {
          final volunteer = volunteers[index];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== GAMBAR =====
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    volunteer.image,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 160,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                      ),
                    ),
                  ),
                ),

                // ===== KONTEN =====
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        volunteer.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            volunteer.location,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        volunteer.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(height: 1.4),
                      ),

                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    VolunteerDetailPage(
                                  volunteer: volunteer,
                                ),
                              ),
                            );
                          },
                          child: const Text("Detail Volunteer"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
