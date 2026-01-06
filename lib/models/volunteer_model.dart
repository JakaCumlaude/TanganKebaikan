class Volunteer {
  final String id;
  final String name;
  final String description;
  final String image;
  final String location;
  final String registrationLink;

  Volunteer({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.location,
    required this.registrationLink,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      location: json['location'],
      registrationLink: json['registrationLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "image": image,
      "location": location,
      "registrationLink": registrationLink,
    };
  }
}
