import 'package:flutter/material.dart';
import '../widgets/bowlbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart' as firebase;

class ListPayers extends StatefulWidget {
  @override
  _ListPayersState createState() => _ListPayersState();
}

class _ListPayersState extends State<ListPayers> {
  Stream<QuerySnapshot> _payerStream;

  @override
  void initState() {
    super.initState();
    _payerStream = firebase.getPayers();
  }

  @override
  void didUpdateWidget(ListPayers oldWidget) {
    setState(() {
      _payerStream = firebase.getPayers();
    });
    super.didUpdateWidget(oldWidget);
  }

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
        stream: _payerStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20.0),
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        return _buildListItem(context, snapshot[index]);
      },
      //children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    return Padding(
      key: ValueKey(data['date']),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(data['date'] + '  ' + data['name']),
          trailing: Icon(Icons.delete),
          onLongPress: () {
            firebase.deletePayer(data.documentID);
          },
        ),
      ),
    );
  }
}
