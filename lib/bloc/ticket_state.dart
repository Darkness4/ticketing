import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ticketing/model/ticket.dart';

@immutable
abstract class TicketState extends Equatable {
  TicketState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class InitialTicketState extends TicketState {}

class LoadingTicketState extends TicketState {}

class LoadedTicketState extends TicketState {
  final Ticket ticket;

  LoadedTicketState(this.ticket) : super(<dynamic>[ticket]);
}
