class Operator {
  final int phoneNumber;
  final String name;
  final String email;
  final String icNumber;
  final String profilePicURL;

  Operator({
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.icNumber,
    required this.profilePicURL,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return (Operator(
      phoneNumber: json['phoneNumber'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      icNumber: json['icNumber'] ?? '',
      profilePicURL: json['profilePicURL'] ?? '',
    ));
  }
}