import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:thiran_task/cubits/case_three/case_three_state.dart';
import 'package:thiran_task/models/ticket.dart';

class TicketCubit extends Cubit<TicketState> {
  final String userId;

  TicketCubit(this.userId) : super(TicketInitial());

  void createTicket(
      {required String title,
      required String description,
      required String location,
      required String attachment,
      required String attachementDetails}) async {
    // var now = DateTime.now();
    // var formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    await FirebaseFirestore.instance.collection('tickets').add({
      'userId': userId,
      'title': title,
      'description': description,
      'location': location,
      'attachment': attachment,
      'details': attachementDetails,
      'reportedDate': DateTime.now(),
    });

    emit(TicketCreated());
  }

  Stream<List<Ticket>> getTickets() async* {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('tickets')
          .where('userId', isEqualTo: userId)
          .get();
      Logger().e(snapshot.docs.first.data());

      var tickets = snapshot.docs
          .map((doc) => Ticket.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      emit(TicketList(tickets));
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
