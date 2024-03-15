import 'package:intl/intl.dart';
import 'user.dart';

class Feedbacks {
  final String feedbackID;
  final User? user;
  final double starRating;
  final List<String> improvementCategories;
  final String message;
  final DateTime receivedAt;

  Feedbacks({
    required this.feedbackID,
    required this.user,
    required this.starRating,
    required this.improvementCategories,
    required this.message,
    required this.receivedAt,
  });

  factory Feedbacks.fromJson(Map<String, dynamic> json) {
    return (Feedbacks(
      feedbackID: json['feedbackID'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      starRating: json['starRating'].toDouble() ?? 0.0,
      improvementCategories: (json['improvementCategories'] as List<dynamic>)
          .map((category) => category.toString())
          .toList(),
      message: json['message'] ?? '',
      receivedAt: DateTime.parse(json['receivedAt']),
    ));
  }
  
  String getFormattedDateTime(DateTime dateTime) {
    const timeZoneOffset = Duration(hours: 8);
    dateTime = dateTime.add(timeZoneOffset);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return '$formattedDate, $formattedTime';
  }
}