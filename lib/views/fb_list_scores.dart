import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/bowlbar.dart';
import 'dart:math';

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

  Widget _heading(DocumentSnapshot document) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(document['date']),
          Text(document['serie'].toString()),
        ],
      ),
    );
  }

  Widget _score(DocumentSnapshot document) {
    List<int> scores = [
      document['akuScore'],
      document['mikkoScore'],
      document['olliScore']
    ];
    var highest = scores.reduce(max);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('Aku'),
              Text(
                document['akuScore'].toString(),
                style: TextStyle(
                  color: document['akuScore'] == highest
                      ? Colors.green
                      : Colors.black,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text('Mikko'),
              Text(
                document['mikkoScore'].toString(),
                style: TextStyle(
                  color: document['mikkoScore'] == highest
                      ? Colors.green
                      : Colors.black,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text('Olli'),
              Text(
                document['olliScore'].toString(),
                style: TextStyle(
                  color: document['olliScore'] == highest
                      ? Colors.green
                      : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _scoreRow(DocumentSnapshot document) {
    return Card(
      child: Column(
        children: <Widget>[
          _heading(document),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          _score(document),
        ],
      ),
    );
  }
}
