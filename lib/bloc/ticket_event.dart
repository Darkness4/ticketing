import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TicketEvent extends Equatable {
  TicketEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class GetTicket extends TicketEvent {
  final String username;
  final String password;

  GetTicket(this.username, this.password)
      : super(<dynamic>[username, password]);
}
