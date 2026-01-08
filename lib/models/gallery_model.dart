class Gallery {
  final String id;
  final String title;
  final String image;
  final String beforeImage;
  final String afterImage;
  final String description;

  Gallery({
    required this.id,
    required this.title,
    required this.image,
    required this.beforeImage,
    required this.afterImage,
    required this.description,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      beforeImage: json['beforeImage'] ?? '',
      afterImage: json['afterImage'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
