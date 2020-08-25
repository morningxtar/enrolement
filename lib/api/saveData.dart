import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:enrolement/constante.dart';
import 'package:enrolement/model/enrole.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Enrole> createEnrole(Enrole enrole) async {
  final http.Response response = await http.post(
    apiSaveEnrole,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
      'nom': enrole.nom,
      'prenoms': enrole.prenoms,
      'dateNaissance': enrole.dateNaissance,
      'lieuNaissance': enrole.lieuNaissance,
      'nationalite': enrole.nationalite,
      'contact': enrole.contact,
      'email': enrole.email
    }),
  );

  print('oo');
  print(response.body.length);
  if (response.statusCode == 200 || response.statusCode == 201 ) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return enrole;
    return Enrole.fromJson(json.decode(response.body));
//    List responseJson = json.decode(response.body);
//    return responseJson.map((m) => new Service.fromJson(m)).toList();
  } else {
    print(Exception);
    throw Exception('Failed to load');
  }
}

Future<Enrole> updateEnrole(Enrole enrole) async {
  final http.Response response = await http.put(
    apiEnrole,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
      'nom': enrole.nom,
      'prenoms': enrole.prenoms,
      'dateNaissance': enrole.dateNaissance,
      'lieuNaissance': enrole.lieuNaissance,
      'nationalite': enrole.nationalite,
      'contact': enrole.contact,
      'email': enrole.email,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Enrole.fromJson(json.decode(response.body));
//    List responseJson = json.decode(response.body);
//    return responseJson.map((m) => new Service.fromJson(m)).toList();
  } else {
    print(Exception);
    throw Exception('Failed to load');
  }
}