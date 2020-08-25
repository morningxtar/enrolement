import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:enrolement/constante.dart';
import 'package:enrolement/model/enrole.dart';
import 'package:enrolement/model/inscription.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../loginLoad.dart';

SharedPreferences _sharedPreferences;
List<Enrole> _enroles = new List<Enrole>();

Future<List<Enrole>> getEnroles() async {
  _enroles.clear();
  final response = await http.get(apiEnrole);
  var dio = new Dio();
  final response1 = await dio.get(apiEnrole);

  if (response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    for (var i = 0; i < response1.data.length; i++) {
      Enrole enrole = new Enrole(
        id: response1.data[i]['id'],
        nom: response1.data[i]['nom'],
        prenoms: response1.data[i]['prenoms'],
        dateNaissance: response1.data[i]['dateNaissance'],
        lieuNaissance: response1.data[i]['lieuNaissance'],
        nationalite: response1.data[i]['nationalite'],
        contact: response1.data[i]['contact'],
        email: response1.data[i]['email'],
      );
      _enroles.add(enrole);
    }

    List responseJson = json.decode(response.body);
    return responseJson.map((m) => new Enrole.fromJson(m)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

bool check = false;
Inscription userConnected = new Inscription();

Future<Inscription> isValidUser(
    String email, String password, BuildContext context) async {
  _sharedPreferences = await SharedPreferences.getInstance();
  final response = await http.get(apiConnexion +
      '?email=' +
      email +
      '&password=' +
      password +
      '?number=' +
      email +
      '&password2=' +
      password);
  var dio = new Dio();
  final response1 = await dio.get(apiConnexion +
      '?email=' +
      email +
      '&password=' +
      password +
      '&number=' +
      email +
      '&password2=' +
      password);
  print('ds' + response1.data.toString());
  if (response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    if (response1.data.isNotEmpty) {
      userConnected.id = response1.data[0]['id'];
      userConnected.firstName = response1.data[0]['firstName'];
      userConnected.lastName = response1.data[0]['lastName'];
      userConnected.phoneNumber = response1.data[0]['phoneNumber'];
      userConnected.phoneNumber = response1.data[0]['identity'];
      userConnected.email = response1.data[0]['email'];
      userConnected.password = response1.data[0]['password'];
      userConnected.comments = response1.data[0]['comments'];
      userConnected.userType = response1.data[0]['userType'];
      //    List responseJson = json.decode(response.body);
      //userConnected = Inscription.fromJson(json.decode(response1.data));
      _sharedPreferences.setString("user", response1.data[0].toString());
      _sharedPreferences.setString(
          "email", response1.data[0]['email'].toString());
      _sharedPreferences.setString(
          "userType", response1.data[0]['userType'].toString());
      check = true;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginLoading()));
      return userConnected;
    } else {
      _sharedPreferences.setString("user", null.toString());
      print(response1.data);
      check = false;
      return null;
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}