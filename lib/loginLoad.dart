import 'dart:async';

import 'package:enrolement/enrolement.dart';
import 'package:enrolement/screens/enrolementScreen.dart';
import 'package:enrolement/screens/enrolesScreen.dart';
import 'package:enrolement/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLoading extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<LoginLoading> {

  SharedPreferences _sharedPreferences;
  String userType;
  @override
  void initState() {
    super.initState();
    instancingSharedPref();
  }

  instancingSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    userType = _sharedPreferences.getString('userType');
    Timer(Duration(seconds: 2), () {
      (userType != 'admin') ?
      NavigationUtils.pushReplacement(context, EnroleSreen()) : NavigationUtils.pushReplacement(context, PersonneEnroleSreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: loadingScreen()
      ),
    );
  }

  Widget loadingScreen() {
    return new Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(strokeWidth: 4.0),
                new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    'Authentification en cours...',
                    style:
                    new TextStyle(color: Colors.green, fontSize: 16.0),
                  ),
                )
              ],
            )));
  }
}
