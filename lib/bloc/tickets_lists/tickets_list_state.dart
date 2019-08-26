import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ticketing/models/ticket.dart';

@immutable
abstract class TicketsListState extends Equatable {
  TicketsListState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class InitialTicketsListState extends TicketsListState {}

class LoadingTicketsListState extends TicketsListState {}

class LoadedTicketsListState extends TicketsListState {
  final List<Ticket> ticketsList;

  LoadedTicketsListState(this.ticketsList) : super(<dynamic>[ticketsList]);
}
