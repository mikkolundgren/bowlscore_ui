import 'package:flutter/material.dart';
import '../widgets/bowlbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart' as firebase;
import 'package:intl/intl.dart';

class ListPayers extends StatefulWidget {
  @override
  _ListPayersState createState() => _ListPayersState();
}

class _ListPayersState extends State<ListPayers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BowlBar(
        title: "Payers",
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildBody(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firebase.getPayers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final payer = data['name']; //firebase.Payer.fromSnapshot(data);
    final millis = data['date']; //new DateTime.fromMillisecondsSinceEpoch(
    //payer.date.millisecondsSinceEpoch);
    final format = new DateFormat('dd.MM.yyyy');
    return Padding(
      key: ValueKey(millis),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(millis),
          trailing: Text(payer),
        ),
      ),
    );
  }
}
