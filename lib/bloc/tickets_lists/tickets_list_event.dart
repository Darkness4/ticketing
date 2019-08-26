import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ticketing/models/ticket.dart';

@immutable
abstract class TicketsListEvent extends Equatable {
  TicketsListEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class GetTicketsList extends TicketsListEvent {}

class TicketsListUpdated extends TicketsListEvent {
  final List<Ticket> tickets;

  TicketsListUpdated(this.tickets);

  @override
  String toString() => 'TicketsListUpdated';
}
