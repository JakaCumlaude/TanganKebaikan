class ActivityHistory {
  final String id;
  final String title;
  final String date;
  final String location;
  final String image;
  final String description;

  ActivityHistory({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.image,
    required this.description,
  });

  factory ActivityHistory.fromJson(Map<String, dynamic> json) {
    return ActivityHistory(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      location: json['location'],
      image: json['image'],
      description: json['description'],
    );
  }
}
