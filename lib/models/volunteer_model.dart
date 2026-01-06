class Volunteer {
  final String id;
  final String name;
  final String city;
  final String imageUrl;
  final int needed;

  Volunteer({
    required this.id,
    required this.name,
    required this.city,
    required this.imageUrl,
    required this.needed,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      // NewsAPI menggunakan 'url' sebagai link unik, 'title' untuk judul, dan 'urlToImage'
      id: json['url'] ?? json['id']?.toString() ?? '', 
      name: json['title'] ?? json['name'] ?? 'Kegiatan Relawan',
      city: json['source'] != null ? json['source']['name'] : (json['city'] ?? 'Indonesia'),
      imageUrl: json['urlToImage'] ?? json['imageUrl'] ?? 'https://via.placeholder.com/150',
      needed: json['needed'] ?? 0,
    );
  }
}