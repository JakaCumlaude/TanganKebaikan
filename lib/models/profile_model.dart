class Profile {
  final String id;
  final String name;
  final String role;
  final int donation;
  final int volunteer;
  final int points;

  Profile({
    required this.id,
    required this.name,
    required this.role,
    required this.donation,
    required this.volunteer,
    required this.points,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'].toString(),
      name: json['name'] ?? '-',
      role: json['role'] ?? '-',
      donation: int.parse(json['donation'].toString()),
      volunteer: int.parse(json['volunteer'].toString()),
      points: int.parse(json['points'].toString()),
    );
  }
}
