import 'package:enrolement/enrolement.dart';
import 'package:enrolement/screens/enrolementScreen.dart';
import 'package:enrolement/screens/enrolesScreen.dart';
import 'package:enrolement/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawer(BuildContext context, String userType) {
  return SizedBox(
    width: 300,
    child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.cover)),
            child: null,
          ),
          Visibility(
            visible: userType != 'admin',
            child: new ListTile(
              title: Text(
                "Enrôler",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: Color.fromRGBO(75, 75, 75, 0.8)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EnroleSreen()),
                );
              },
              leading: Icon(
                Icons.add_box,
                color: Color.fromRGBO(71, 71, 70, 0.8),
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: new ListTile(
              title: new Text(
                'Personnes enrôlées',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: Color.fromRGBO(75, 75, 75, 0.8)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PersonneEnroleSreen()),
                );
              },
              leading: Icon(
                Icons.history,
                color: Color.fromRGBO(71, 71, 70, 0.8),
              ),
            ),
          ),
          Visibility(
            visible: userType == 'admin',
            child: Builder(
              builder: (context) => ListTile(
                title: new Text(
                  'Statistiques',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Color.fromRGBO(75, 75, 75, 0.8)),
                ),
                onTap: () async {
//                  Navigator.pushReplacement(
//                    context,
//                    MaterialPageRoute(
//                        //builder: (context) => CheckSreen()),
//                  );
                },
                leading: Icon(
                  Icons.insert_chart,
                  color: Color.fromRGBO(71, 71, 70, 0.8),
                ),
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: new ListTile(
              title: new Text(
                'Déconnexion',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: Color.fromRGBO(75, 75, 75, 0.8)),
              ),
              onTap: () {
                logout(context);
              },
              leading: Icon(
                Icons.subdirectory_arrow_left,
                color: Color.fromRGBO(71, 71, 70, 0.8),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

SharedPreferences _sharedPreferences;

logout(BuildContext context) async {
  _sharedPreferences = await SharedPreferences.getInstance();
  _sharedPreferences.clear();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginSreen()),
  );
}
