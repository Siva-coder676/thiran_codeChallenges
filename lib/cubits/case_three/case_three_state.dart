

import 'package:equatable/equatable.dart';
import 'package:thiran_task/models/ticket.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitial extends TicketState {}

class TicketCreated extends TicketState {}

class TicketList extends TicketState {
  final List<Ticket> tickets;

  TicketList(this.tickets);

  @override
  List<Object> get props => [tickets];
}
