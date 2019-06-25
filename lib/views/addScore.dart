import 'package:flutter/material.dart';
import '../widgets/bowlbar.dart';
import '../services/backend.dart' as backend;

class AddScoreForm extends StatefulWidget {
  @override
  _AddScoreState createState() => _AddScoreState();
}

class _AddScoreState extends State<AddScoreForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _addScoreFormKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  var _akuScore = 0;
  var _mikkoScore = 0;
  var _olliScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: BowlBar(title: "Add score"),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: _addScoreForm(),
      ),
    );
  }

  Widget _addScoreForm() {
    return Form(
      key: _addScoreFormKey,
      child: Center(
        widthFactor: 33.0,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Aku",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
              initialValue: '0',
              keyboardType: TextInputType.number,
              //controller: _controller,
              validator: (value) => _validateScore(value),
              onSaved: (val) => _akuScore = int.parse(val),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Mikko",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
              initialValue: '0',
              keyboardType: TextInputType.number,
              //controller: _controller,
              validator: (value) => _validateScore(value),
              onSaved: (val) => _mikkoScore = int.parse(val),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Olli",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
              initialValue: '0',
              keyboardType: TextInputType.number,
              //controller: _controller,
              validator: (value) => _validateScore(value),
              onSaved: (val) => _olliScore = int.parse(val),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_addScoreFormKey.currentState.validate()) {
                    _submitForm();
                  }
                },
                child: Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _validateScore(String value) {
    int val = int.tryParse(value);
    if (val == null) {
      return "Please enter numeric value";
    }
    if (val > 300 || val < 0) {
      return "Please enter value between 0 and 300";
    }
    return null;
  }

  void _submitForm() {}

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
