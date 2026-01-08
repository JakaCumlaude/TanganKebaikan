import 'package:flutter/material.dart';
import '../../models/gallery_model.dart';

class GalleryDetailPage extends StatelessWidget {
  final Gallery gallery;

  const GalleryDetailPage({super.key, required this.gallery});

  Widget imageBox(String url) {
    return Expanded(
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            color: Colors.grey.shade300,
            child: const Icon(Icons.image_not_supported, size: 40),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Dampak")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER IMAGE
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Image.network(
                gallery.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, size: 60),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gallery.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(gallery.description),
                  const SizedBox(height: 20),

                  const Text(
                    "Perubahan Visual (Before & After)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      imageBox(gallery.beforeImage),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.arrow_forward),
                      ),
                      imageBox(gallery.afterImage),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
