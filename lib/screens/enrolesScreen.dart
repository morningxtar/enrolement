import 'dart:convert';

import 'package:enrolement/api/getData.dart';
import 'package:enrolement/model/enrole.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../appbar.dart';
import '../drawer.dart';

class PersonneEnroleSreen extends StatefulWidget {
  @override
  PersonneEnroleState createState() => new PersonneEnroleState();
}

class PersonneEnroleState extends State<PersonneEnroleSreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  Future<List<Enrole>> futureEnroles;
  String userType;

  instancingSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    userType = _sharedPreferences.getString('userType');
    setState(() {
      futureEnroles = getEnroles();
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    instancingSharedPref();
  }

  Widget enrolesScreen() {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Container(
      child: FutureBuilder<List<Enrole>>(
        future: futureEnroles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Enrole enrole = snapshot.data[index];
                  return Column(
                    children: <Widget>[
                      // Widget to display the list of project
                      Container(
                        padding:
                        EdgeInsets.only(left: 15, right: 15, top: 10),
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: (){

                          },
                          child: Card(
                            elevation: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Nom : '+ enrole.nom),
                                Text('Prenoms : '+ enrole.prenoms),
                                Text('Date de naissance : '+ enrole.dateNaissance),
                                Text('Lieu de naissance : '+ enrole.lieuNaissance),
                                Text('Nationalité : '+ enrole.nationalite),
                                Text('Téléphone : '+ enrole.contact),
                                Text('Email : '+ enrole.email),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            print("${snapshot.error}");
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        drawer: drawer(context, userType),
        appBar: appbar('Personnes enrôlées'),
        body: enrolesScreen());
  }
}
