class Project {
  final String id, title, description, image, target, location, collected;

  Project({
    required this.id, required this.title, required this.description,
    required this.image, required this.target, required this.location,
    this.collected = "0",
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Tanpa Judul',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString() ?? 'https://via.placeholder.com/300',
      target: json['target']?.toString() ?? '0',
      location: json['location']?.toString() ?? 'Lokasi tidak tersedia',
      collected: json['collected']?.toString() ?? '0',
    );
  }
}