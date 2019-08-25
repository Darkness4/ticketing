import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ticketing/model/ticket.dart';
import './bloc.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  @override
  TicketState get initialState => InitialTicketState();

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    if (event is GetTicket) {
      yield LoadingTicketState();
      final Ticket ticket =
          await _fetchFromFirestore(event.username, event.password);
      yield LoadedTicketState(ticket);
    }
  }
}

_fetchFromFirestore(dynamic a, dynamic b) {}
