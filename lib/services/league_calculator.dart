import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_service.dart';

class League {
  int aku;
  int mikko;
  int olli;
  League({this.aku, this.mikko, this.olli});
}

League calculate() {
  int _akuPts = 0;
  int _mikkoPts = 0;
  int _olliPts = 0;

  List<DocumentSnapshot> docs = getScoresForLeague();

  for (DocumentSnapshot d in docs) {
    serieBest(_akuPts, _mikkoPts, _olliPts, d);
  }
  return new League(aku: _akuPts, mikko: _mikkoPts, olli: _olliPts);
}

void serieBest(int aku, int mikko, int olli, DocumentSnapshot d) {
  final int akuScore = int.parse(d.data['akuScore']);
  final int mikkoScore = int.parse(d.data['mikkoScore']);
  final int olliScore = int.parse(d.data['olliScore']);
  if (akuScore >= mikkoScore && akuScore >= olliScore) {
    aku++;
  }
  if (mikkoScore >= akuScore && mikkoScore >= olliScore) {
    mikko++;
  }
  if (olliScore >= akuScore && olliScore >= mikkoScore) {
    olli++;
  }
}
