import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ticketing/models/ticket.dart';

class LoadTicketsListEvent extends TicketsListEvent {}

@immutable
abstract class TicketsListEvent extends Equatable {
  TicketsListEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class UpdatedTicketsListEvent extends TicketsListEvent {
  final List<Ticket> tickets;

  UpdatedTicketsListEvent(this.tickets) : super(<dynamic>[tickets]);
}

class PostTicketEvent extends TicketsListEvent {
  final String username;
  final String command;

  PostTicketEvent(this.username, this.command)
      : super(<dynamic>[username, command]);
}
