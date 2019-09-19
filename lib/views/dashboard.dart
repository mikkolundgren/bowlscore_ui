import 'package:flutter/material.dart';
import './addPayers.dart';
import '../widgets/bowlbar.dart';
import './addScore.dart';
import './fb_list_scores.dart';
import './listPayers.dart';
import './league_page.dart';
import './chartPage.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BowlBar(
        title: "Bowlscore",
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(3.0),
            children: <Widget>[
              makeDashboard("Payers", Icons.ac_unit, "showPayers"),
              makeDashboard("Add payer", Icons.ac_unit, "addPayer"),
              makeDashboard("Scores", Icons.ac_unit, "scores"),
              makeDashboard("Add scores", Icons.ac_unit, "addScore"),
              makeDashboard("League", Icons.ac_unit, "league"),
              makeDashboard("Charts", Icons.ac_unit, "charts"),
            ],
          )),
    );
  }

  Card makeDashboard(String title, IconData icon, String action) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        child: InkWell(
          onTap: () {
            _showPage(action);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Center(
                child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                  child: Text(title,
                      style: TextStyle(fontSize: 18.0, color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }

  _showPage(String action) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (action) {
            case "showPayers":
              return ListPayers();
            case "addPayer":
              return AddPayerForm();
            case "addScore":
              return AddScoreForm();
            case "scores":
              return FB_ListScores();
            case "league":
              return LeaguePage();
            case "charts":
              return ChartPage();
            default:
              return PayersPage();
          }
        },
      ),
    );
  }
}
