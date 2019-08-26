import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Ticket extends Equatable {
  final String ticketId;
  final String username;
  final String command;
  final DateTime dateTime;

  Ticket({
    @required this.dateTime,
    this.ticketId = '',
    this.command = '',
    this.username = '',
  }) : super(<dynamic>[ticketId, command, username, dateTime]);
}
