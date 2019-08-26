import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/models/ticket.dart';

import 'tickets.dart';

class TicketScreen extends StatefulWidget {
  final TicketsBloc _ticketBloc;

  const TicketScreen({
    @required TicketsBloc ticketBloc,
    Key key,
  })  : _ticketBloc = ticketBloc,
        super(key: key);

  @override
  TicketScreenState createState() {
    return TicketScreenState(_ticketBloc);
  }
}

class TicketScreenState extends State<TicketScreen> {
  final TicketsBloc _ticketBloc;

  TicketScreenState(this._ticketBloc);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<TicketsBloc, TicketsListState>(
        builder: (BuildContext context, TicketsListState state) {
          if (state is InitialTicketsListState) {
            return const Center();
          } else if (state is LoadingTicketsListState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedTicketsListState) {
            return _buildColumn(context, state.ticketsList);
          } else {
            return const Text("State not implemented");
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this._ticketBloc.dispatch(LoadTicketsListEvent());
  }

  ListView _buildColumn(BuildContext context, List<Ticket> tickets) {
    final TicketsBloc bloc = BlocProvider.of<TicketsBloc>(context);
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'There are ${tickets.length} tickets',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ),
        ),
        const Divider(),
        Card(
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.black),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (Ticket ticket in tickets)
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "[${ticket.dateTime.toIso8601String()}] ${ticket.username}: ${ticket.command}",
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.white,
                          onPressed: () =>
                              bloc.dispatch(DeleteTicketEvent(ticket)),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
        const Divider(),
        Form(
          key: bloc.formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: bloc.usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Value is Empty';
                  } else {
                    return null;
                  }
                },
              ),
              const Divider(color: Colors.transparent),
              TextFormField(
                controller: bloc.commandController,
                focusNode: bloc.commandFocus,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Command',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Value is Empty';
                  } else {
                    return null;
                  }
                },
              ),
              FloatingActionButton.extended(
                label: const Text('Send'),
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (bloc.formKey.currentState.validate()) {
                    bloc.dispatch(PostTicketEvent(bloc.usernameController.text,
                        bloc.commandController.text));
                    bloc.commandController.clear();
                    bloc.commandFocus.unfocus();
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
