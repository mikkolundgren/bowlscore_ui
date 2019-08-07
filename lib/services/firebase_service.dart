import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getScores() {
  return Firestore.instance
      .collection('scores')
      .orderBy('date', descending: true)
      .snapshots();
}

Stream<QuerySnapshot> getPayers() {
  return Firestore.instance
      .collection('payers')
      .orderBy('date', descending: true)
      .snapshots();
}

void addScore(akuScore, mikkoScore, olliScore, serie) {
  // todo validate values
  Firestore.instance.collection('scores').document().setData({
    'akuScore': akuScore,
    'mikkoScore': mikkoScore,
    'olliScore': olliScore,
    'serie': serie,
    'date': DateTime.now()
  });
}

void addPayer(name, date) {
  Firestore.instance
      .collection('payers')
      .document()
      .setData({'name': name, 'date': date});
}

void deletePayer(String id) {
  Firestore.instance.collection('payers').document(id).delete();
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
  int akuScore;
  int mikkoScore;
  int olliScore;
  int serie;
  Timestamp date;
  Serie(
      {this.akuScore, this.mikkoScore, this.olliScore, this.serie, this.date});
  factory Serie.fromMap(Map<String, dynamic> map) {
    return Serie(
        akuScore: map['akuScore'],
        mikkoScore: map['mikkoScore'],
        olliScore: map['olliScore'],
        serie: map['serie'],
        date: map['date']);
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
