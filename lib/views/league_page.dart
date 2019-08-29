import '../services/league_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/bowlbar.dart';

class LeaguePage extends StatefulWidget {
  LeaguePage({Key key}) : super(key: key);

  _LeaguePageState createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BowlBar(title: "League"),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("Hall of Shame"),
            _leagueFuture(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<League> _leagueFuture() {
    return FutureBuilder<League>(
        future: calculateLeague(),
        builder: (BuildContext context, AsyncSnapshot<League> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return _progress();
            case ConnectionState.done:
              return _leagueGrid(snapshot.data);
          }
          return null;
        });
  }

  Widget _progress() {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  Widget _leagueGrid(League _league) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              Text("Name"),
              Text("Series"),
              Text("Totals"),
              Text("DaysBest"),
              Text("POINTS"),
            ],
          ),
          TableRow(
            children: <Widget>[
              Text("Aku"),
              Text(_league.akuSeries.toString()),
              Text(_league.akuTotal.toString()),
              Text(_league.akuBestOfDay.toString()),
              Text(_league.akuPoints.toString()),
            ],
          ),
          TableRow(
            children: <Widget>[
              Text("Mikko"),
              Text(_league.mikkoSeries.toString()),
              Text(_league.mikkoTotal.toString()),
              Text(_league.mikkoBestOfDay.toString()),
              Text(_league.mikkoPoints.toString()),
            ],
          ),
          TableRow(
            children: <Widget>[
              Text("Olli"),
              Text(_league.olliSeries.toString()),
              Text(_league.olliTotal.toString()),
              Text(_league.olliBestOfDay.toString()),
              Text(_league.olliPoints.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
