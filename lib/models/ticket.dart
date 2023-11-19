

import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final String title;
  final String description;
  final String location;
  final String attachment;
  final DateTime reportedDate;

  Ticket({
    required this.title,
    required this.description,
    required this.location,
    required this.attachment,
    required this.reportedDate,
  });

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      title: map['title'],
      description: map['description'],
      location: map['location'],
      attachment: map['attachment'],
      reportedDate: (map['reportedDate'] as Timestamp).toDate(),
    );
  }
}
