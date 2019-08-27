import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_service.dart';

class League {
  int akuSeries = 0;
  int mikkoSeries = 0;
  int olliSeries = 0;

  int akuTotal = 0;
  int mikkoTotal = 0;
  int olliTotal = 0;

  int akuBestOfDay = 0;
  int mikkoBestOfDay = 0;
  int olliBestOfDay = 0;
}

class Scores {
  final int aku;
  final int mikko;
  final int olli;
  Scores({this.aku, this.mikko, this.olli});
}

League calculateLeague([bool fullteam = true]) {
  League league = new League();

  List<DocumentSnapshot> docs = getScoresForLeague();

  List<Scores> dayScores = [];

  for (DocumentSnapshot d in docs) {
    Scores s = _parseScores(d);
    if (fullteam) {
      if ((s.aku > 0 && s.mikko > 0 && s.olli > 0) == false) {
        continue;
      }
    }
    _serieBest(league, s);
    String currentDate = docs[0].data['date'];
    if (currentDate == d['date']) {
      dayScores.add(s);
    } else {
      _dayPoints(league, dayScores);
      dayScores.clear();
      currentDate = d['date'];
      dayScores.add(s);
    }
  }
  return league;
}

Scores _parseScores(DocumentSnapshot d) {
  return Scores(
      aku: int.parse(d['akuScore']),
      mikko: int.parse(d['mikkoScore']),
      olli: int.parse(d['olliScore']));
}

void _serieBest(League league, Scores s) {
  if (s.aku >= s.mikko && s.aku >= s.olli) {
    league.akuSeries++;
  }
  if (s.mikko >= s.aku && s.mikko >= s.olli) {
    league.mikkoSeries++;
  }
  if (s.olli >= s.aku && s.olli >= s.mikko) {
    league.olliSeries++;
  }
}

void _dayPoints(League l, List<Scores> dayScores) {
  int akuTotal, olliTotal, mikkoTotal = 0;
  int akuBest, mikkoBest, olliBest = 0;
  for (Scores s in dayScores) {
    akuTotal += s.aku;
    mikkoTotal += s.mikko;
    olliTotal += s.olli;
    if (s.aku >= akuBest) akuBest = s.aku;
    if (s.mikko >= mikkoBest) mikkoBest = s.mikko;
    if (s.olli >= olliBest) olliBest = s.olli;
  }
  if (akuTotal >= mikkoTotal && akuTotal >= olliTotal) l.akuTotal++;
  if (mikkoTotal >= akuTotal && mikkoTotal >= olliTotal) l.mikkoTotal++;
  if (olliTotal >= akuTotal && olliTotal >= mikkoTotal) l.olliTotal++;
  if (akuBest >= mikkoBest && akuBest >= olliBest) l.akuBestOfDay++;
  if (mikkoBest >= akuBest && mikkoBest >= olliBest) l.mikkoBestOfDay++;
  if (olliBest >= akuBest && olliBest >= mikkoBest) l.olliBestOfDay++;
}
