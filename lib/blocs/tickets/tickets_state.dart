import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ticketing/models/ticket.dart';

class InitialTicketsListState extends TicketsListState {}

class LoadedTicketsListState extends TicketsListState {
  final List<Ticket> ticketsList;

  LoadedTicketsListState(this.ticketsList) : super(<dynamic>[ticketsList]);
}

class LoadingTicketsListState extends TicketsListState {}

@immutable
abstract class TicketsListState extends Equatable {
  TicketsListState([List<dynamic> props = const <dynamic>[]]) : super(props);
}
