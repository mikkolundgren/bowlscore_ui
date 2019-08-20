import 'package:flutter/material.dart';
import '../widgets/bowlbar.dart';
import '../widgets/image_row.dart';
import '../services/service_locator.dart';
import '../model/app_model.dart';
import 'package:intl/intl.dart';
import '../services/firebase_service.dart' as backend;

class PayersPage extends StatelessWidget {
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: BowlBar(
        title: "Payers",
      ),
    );
  }
}

class AddPayerForm extends StatefulWidget {
  @override
  _AddPayerState createState() => _AddPayerState();
}

class _AddPayerState extends State<AddPayerForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _addPayerFormKey = GlobalKey<FormState>();
  String _currentBowler = 'Aku';
  String _currentDate = '';

  @override
  void initState() {
    locator<AppModel>().addListener(update);
    super.initState();
  }

  update() {
    if (!this.mounted) {
      return;
    }
    setState(() {
      _currentBowler = locator<AppModel>().bowler;
      print('currentBowler $_currentBowler');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: BowlBar(title: "Add payer"),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: _addPayerForm(context),
      ),
    );
  }

  Widget _addPayerForm(context) {
    return Form(
      key: _addPayerFormKey,
      child: Center(
          widthFactor: 33.0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              TextFormField(
                  decoration: InputDecoration(
                    labelText: "Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialValue: DateFormat('dd.MM.yyyy').format(DateTime.now()),
                  onSaved: (val) {
                    setState(() {
                      _currentDate = val;
                    });
                  }),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              ImageRowWidget(),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text('Submit'),
                ),
              )
            ],
          )),
    );
  }

  void _submitForm() {
    _addPayerFormKey.currentState.save();
    try {
      backend.addPayer(_currentBowler, _currentDate);
      _showMessage("Saved payer $_currentBowler");
    } catch (err) {
      _showMessage("Error.. $err", Colors.red);
    }
  }

  void _showMessage(String message, [MaterialColor color = Colors.green]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: Text(message),
    ));
  }
}
