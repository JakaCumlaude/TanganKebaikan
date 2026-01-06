class Project {
  final String id;
  final String title;
  final String description;
  final String status;
  final String image;
  final String target;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.image,
    required this.target,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'].toString(), // 🔥 FIX
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Berjalan',
      image: json['image']?.toString() ??
          'https://via.placeholder.com/300',
      target: json['target']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "status": status,
      "image": image,
      "target": target,
    };
  }
}
