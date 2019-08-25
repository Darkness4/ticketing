import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Ticket extends Equatable {
  final String ticketId;
  final String username;
  final String command;

  Ticket({
    @required this.ticketId,
    @required this.command,
    @required this.username,
  }) : super(<dynamic>[ticketId, command, username]);
}
