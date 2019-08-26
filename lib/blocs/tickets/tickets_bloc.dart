import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ticketing/models/ticket.dart';
import 'package:ticketing/services/firebase_api.dart';

import 'tickets.dart';

class TicketsBloc extends Bloc<TicketsListEvent, TicketsListState> {
  final FirebaseAPI _firebaseAPI;
  StreamSubscription<List<Ticket>> _ticketsListSubscription;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController commandController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode commandFocus = FocusNode();

  TicketsBloc({@required FirebaseAPI firebaseAPI}) : _firebaseAPI = firebaseAPI;

  @override
  TicketsListState get initialState => InitialTicketsListState();

  @override
  Stream<TicketsListState> mapEventToState(
    TicketsListEvent event,
  ) async* {
    if (event is LoadTicketsListEvent) {
      yield* _mapLoadTicketsListToState();
    } else if (event is UpdatedTicketsListEvent) {
      yield* _mapTicketsListUpdateToState(event);
    } else if (event is PostTicketEvent) {
      yield* _mapPostTicketToState(event);
    }
  }

  Stream<TicketsListState> _mapLoadTicketsListToState() async* {
    yield LoadingTicketsListState();
    await _ticketsListSubscription?.cancel();
    _ticketsListSubscription = _firebaseAPI.fetchTickets().listen(
      (List<Ticket> tickets) {
        tickets.sort((Ticket ticket1, Ticket ticket2) =>
            ticket1.dateTime.compareTo(ticket2.dateTime));
        dispatch(
          UpdatedTicketsListEvent(tickets),
        );
      },
    );
  }

  Stream<TicketsListState> _mapTicketsListUpdateToState(
      UpdatedTicketsListEvent event) async* {
    yield LoadedTicketsListState(event.tickets);
  }

  Stream<TicketsListState> _mapPostTicketToState(PostTicketEvent event) async* {
    await _firebaseAPI.postTicket(event.username, event.command);
  }
}
