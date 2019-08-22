import '../services/league_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/bowlbar.dart';

class LeaguePage extends StatefulWidget {
  LeaguePage({Key key}) : super(key: key);

  _LeaguePageState createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  League _league;

  @override
  void initState() {
    super.initState();
    _league = calculateLeague();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BowlBar(title: "League"),
      body: Container(
        child: _leagueGrid(),
      ),
    );
  }

  Widget _leagueGrid() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: <Widget>[
          Text("Aku"),
          Text(_league.akuSeries.toString()),
          Text(_league.akuTotal.toString()),
          Text((_league.akuSeries + _league.akuTotal).toString())
        ]),
        TableRow(
          children: <Widget>[
            Text("Mikko"),
            Text(_league.mikkoSeries.toString()),
            Text(_league.mikkoTotal.toString()),
            Text((_league.mikkoSeries + _league.mikkoTotal).toString())
          ],
        ),
        TableRow(
          children: <Widget>[
            Text("Olli"),
            Text(_league.olliSeries.toString()),
            Text(_league.olliTotal.toString()),
            Text((_league.olliSeries + _league.olliTotal).toString())
          ],
        ),
      ],
    );
  }
}
