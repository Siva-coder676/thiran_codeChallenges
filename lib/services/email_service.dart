
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:sqflite/sqflite.dart';
import 'package:thiran_task/models/transaction_data.dart';

class EmailComponent {
  void sendEmail(String adminEmail, List<TransactionData> errorTransactions) async {
    final Email email = Email(
      body: 'There are error records in the database',
      subject: 'Error Records Notification',
      recipients: [adminEmail],
    );

    try {
      await FlutterEmailSender.send(email);
      print('Email sent to $adminEmail');
    } catch (e) {
      print('Error sending email: $e');
      throw e;
    }
  }
}
