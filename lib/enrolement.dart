import 'package:enrolement/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme = ThemeData(
    fontFamily: 'Oxygen'
);

class Enrolement extends StatefulWidget {

  @override
  _EnrolementState createState() => _EnrolementState();
}

class _EnrolementState extends State<Enrolement> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Enrôlement',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: new LoginSreen(),
    );
  }
}