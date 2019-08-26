import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketing/models/ticket.dart';

class FirebaseAPI extends Equatable {
  final Firestore instance = Firestore.instance;

  Future<void> postTicket(String username, String command) async {
    await instance.collection('tickets').document().setData(<String, dynamic>{
      'username': username,
      'command': command,
      'timestamp': Timestamp.fromDate(DateTime.now()),
    });
  }

  Stream<List<Ticket>> fetchTickets() async* {
    await for (final QuerySnapshot data
        in instance.collection('tickets').snapshots()) {
      yield data.documents
          .map((final DocumentSnapshot doc) => Ticket(
                command: doc['command'],
                ticketId: doc.documentID,
                username: doc['username'],
                dateTime: doc['timestamp'].toDate(),
              ))
          .toList();
    }
  }
}
