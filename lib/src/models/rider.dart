class Rider {
  final int phoneNumber;
  final String name;
  final String email;
  final String profilePicURL;

  Rider({
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.profilePicURL,
  });

  factory Rider.fromJson(Map<String, dynamic> json) {
    return (Rider(
      phoneNumber: json['phoneNumber'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profilePicURL: json['profilePicURL'] ?? '',
    ));
  }
}