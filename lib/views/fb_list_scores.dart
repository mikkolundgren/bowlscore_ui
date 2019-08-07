import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/bowlbar.dart';

import '../services/firebase_service.dart' as fb;

class FB_ListScores extends StatefulWidget {
  FB_ListScores({Key key}) : super(key: key);

  _FB_ListScoresState createState() => _FB_ListScoresState();
}

class _FB_ListScoresState extends State<FB_ListScores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BowlBar(title: "Scores"),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: _scores(),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> _scores() {
    return StreamBuilder<QuerySnapshot>(
      stream: fb.getScores(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return _scoreRow(document);
              }).toList(),
            );
        }
      },
    );
  }

  Widget _scoreRow(DocumentSnapshot document) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Aku\t',
                textAlign: TextAlign.left,
              ),
              Text(
                document['akuScore'].toString(),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          Row(
            children: [
              Text('Mikko'),
              Text(document['mikkoScore'].toString()),
            ],
          ),
          Row(
            children: [
              Text('Olli'),
              Text(document['olliScore'].toString()),
            ],
          )
        ],
      ),
    );
  }
}
