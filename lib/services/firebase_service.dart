import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getScores() {
  return Firestore.instance
      .collection('scores')
      .orderBy('date', descending: false)
      .snapshots();
}

Stream<QuerySnapshot> getPayers() {
  return Firestore.instance
      .collection('payers')
      .orderBy('date', descending: false)
      .snapshots();
}

class Payer {
  final Timestamp date;
  final String name;
  final DocumentReference reference;
  Payer({this.date, this.name, this.reference});
  Payer.fromMap(Map<String, dynamic> map, {this.reference})
      : date = map['date'],
        name = map['name'];

  Payer.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class Serie {
  String name;
  int score;
  int serieId;
  Serie({this.name, this.score, this.serieId});
  factory Serie.fromMap(Map<String, dynamic> map) {
    return Serie(
        name: map['name'], score: map['score'], serieId: map['serieId']);
  }
}

class Score {
  final Timestamp date;
  final List<Serie> series;

  final DocumentReference reference;

  Score({this.date, this.series, this.reference});

  Score.fromMap(Map<String, dynamic> map, {this.reference})
      : date = map['date'],
        series = map['series'] != null ? List<Serie>.from(map['series']) : null;

  Score.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$date>";

  Map<String, dynamic> toJson() => {'date': date, 'series': series};
}
