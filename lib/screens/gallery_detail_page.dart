import 'package:flutter/material.dart';

class GalleryDetailPage extends StatelessWidget {
  const GalleryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Detail Dampak'),
              background: Image(
                image: NetworkImage('https://via.placeholder.com/600x400'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lencana Kontributor
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.amber),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.stars, color: Colors.amber),
                          SizedBox(width: 10),
                          Expanded(child: Text('Anda adalah 1 dari 150 pahlawan yang mewujudkan proyek ini!', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text('Perubahan Visual (Before & After)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    // Simulasi Before & After Slider
                    Row(
                      children: [
                        Expanded(child: Column(children: [Image.network('https://via.placeholder.com/150'), const Text('Sebelum')])),
                        const Icon(Icons.arrow_forward),
                        Expanded(child: Column(children: [Image.network('https://via.placeholder.com/150'), const Text('Sesudah')])),
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    const Text('Cerita Penerima Manfaat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text(
                      '"Terima kasih donatur! Sekarang anak-anak kami tidak perlu berjalan 2km lagi untuk mencari air bersih." - Pak RT Desa A',
                      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black87),
                    ),

                    const SizedBox(height: 30),
                    const Text('Transparansi Dana', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.receipt_long, color: Colors.blue),
                      title: const Text('Lihat Nota & Laporan Keuangan'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                    
                    const Divider(),
                    const SizedBox(height: 20),
                    const Text('Berikan Reaksi Anda:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _reactionButton(Icons.sentiment_very_satisfied, 'Bangga'),
                        _reactionButton(Icons.favorite, 'Terharu'),
                        _reactionButton(Icons.auto_awesome, 'Luar Biasa'),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _reactionButton(IconData icon, String label) {
    return Column(
      children: [
        IconButton(onPressed: () {}, icon: Icon(icon, color: Colors.blue, size: 30)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}