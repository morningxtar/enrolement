import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:enrolement/api/saveData.dart';
import 'package:enrolement/model/enrole.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../appbar.dart';
import '../drawer.dart';

class EnroleSreen extends StatefulWidget {
  @override
  EnroleSreenState createState() => new EnroleSreenState();
}

class EnroleSreenState extends State<EnroleSreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  var _formKey = GlobalKey<FormState>();
  Enrole _enrole = Enrole();
  List<String> services = [];
  List<int> hoursValue = [];
  List<int> hours = [];
  List<String> postes = ['Liste des machines'];
  FocusNode _focusNode;

  int year;
  int month;
  int day;
  int hour;

  int selected;
  int selected2;
  String userType;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _focusNode = FocusNode();
    setState(() {
      print(DateTime.now().millisecondsSinceEpoch);
      year = DateTime.now().year;
      month = DateTime.now().month;
      day = DateTime.now().day;
      day = DateTime.now().hour;
      instancingSharedPref();
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();

    super.dispose();
  }

  instancingSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    userType = _sharedPreferences.getString('userType');
  }

  Widget reservationScreen() {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    List<String> doubleList =
        List<String>.generate(393, (int index) => '${index * .25 + 1}');
    List<DropdownMenuItem> menuItemList = doubleList
        .map((val) => DropdownMenuItem(value: val, child: Text(val)))
        .toList();
    return Stack(
      children: <Widget>[
        Container(
//          decoration: BoxDecoration(
//              color: Colors.red,
//              image: DecorationImage(
//            image: AssetImage('assets/images/logo.png'),
//            fit: BoxFit.contain,
//            alignment: Alignment.topCenter,
//          )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 23, right: 23, top: 23),
            child: reservationForm(),
          ),
        ),
      ],
    );
  }

  Widget reservationForm() {
    List<DropdownMenuItem> menuPoste;
    List<DropdownMenuItem> menuService;
    setState(() {
      menuPoste = postes
          .map((val) => DropdownMenuItem(value: val, child: Text(val)))
          .toList();
      menuService = services
          .map((val) => DropdownMenuItem(value: val, child: Text(val)))
          .toList();
    });
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom',
                  prefixIcon: Icon(Icons.person_outline),
                  labelStyle: TextStyle(fontSize: 15)),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Prenoms',
                  prefixIcon: Icon(Icons.person_outline),
                  labelStyle: TextStyle(fontSize: 15)),
              onSaved: (String value) {
                _enrole.prenoms = value;
              },
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: DateTimeField(
              onChanged: (DateTime date) {
                setState(() {
                  print(date);
                  if (date != null) {
                    _enrole.dateNaissance = date.day.toString() +
                        '-' +
                        date.month.toString() +
                        '-' +
                        date.year.toString();
                    setState(() {
                      hoursControl(date, DateTime.now());
                    });
                  }
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date de naissance',
                  prefixIcon: Icon(Icons.date_range),
                  labelStyle: TextStyle(fontSize: 15)),
              format: DateFormat("yyyy-MM-dd"),
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.parse("1900-01-01 00:00:00.000"),
                    initialDate: currentValue ?? DateTime.parse("1996-01-01 00:00:00.000"),
                    lastDate: DateTime.now());

                return date;
              },
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Lieu de naissance',
                  prefixIcon: Icon(Icons.person_outline),
                  labelStyle: TextStyle(fontSize: 15)),
              onSaved: (String value) {
                _enrole.lieuNaissance = value;
              },
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nationalité',
                  prefixIcon: Icon(Icons.person_outline),
                  labelStyle: TextStyle(fontSize: 15)),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Téléphone',
                  prefixIcon: Icon(Icons.smartphone),
                  labelStyle: TextStyle(fontSize: 15)),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],

              onSaved: (String value) {
                _enrole.contact = value;
              },
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  labelStyle: TextStyle(fontSize: 15)),
              onSaved: (String value) {
                _enrole.email = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7, bottom: 5),
            child: Builder(
              builder: (context) => MaterialButton(
                onPressed: () async {
                  _sharedPreferences = await SharedPreferences.getInstance();
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print(_enrole.id);
                    print(_enrole.nom);
                    print(_enrole.prenoms);
                    print(_enrole.dateNaissance);
                    print(_enrole.lieuNaissance);
                    print(_enrole.nationalite);
                    print(_enrole.contact);
                    print(_enrole.email);
                    createEnrole(_enrole).then((value) {
                      print(value);
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text('Personne enrôlées!'),
                        backgroundColor: Colors.blue.shade900,
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    });
                    _formKey.currentState.reset();
                  }
                },
                //since this is only a UI app
                child: Text(
                  'ENROLER',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SFUIDisplay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.green,
                elevation: 0,
                minWidth: 400,
                height: 50,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void hoursControl(DateTime dateChosen, DateTime currentDate) {
    int timeOver;
    hoursValue.clear();
    if (dateChosen != null) {
      if (dateChosen.day == currentDate.day &&
          dateChosen.month == currentDate.month &&
          dateChosen.year == currentDate.year) {
        if (currentDate.hour <= 16) {
          timeOver = 16 - currentDate.hour;
          this.hoursValue = [];
          for (var i = currentDate.hour; i <= 16; i++) {
            this.hoursValue.add(i);
          }
        } else {
          this.hoursValue = [];
        }
      } else {
        this.hoursValue = [];
        for (var i = 8; i <= 16; i++) {
          this.hoursValue.add(i);
        }
      }
      print(this.hoursValue);
    }
  }

  void numberHours(hourDeb) {
    hours.clear();
    print(hourDeb);
    if (hourDeb < hoursValue.length) {
      hours.add(1);
      hours.add(2);
    } else {
      if (17 - hourDeb > 1) {
        hours.add(1);
        hours.add(2);
      } else {
        hours.add(1);
      }
    }

    print(hours);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        drawer: drawer(context, userType),
        appBar: appbar('Enrôlement'),
        body: reservationScreen());
  }
}
