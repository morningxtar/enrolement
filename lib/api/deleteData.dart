import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:enrolement/constante.dart';
import 'package:enrolement/model/enrole.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Enrole> deleteEnrole(var id) async {
  final http.Response response = await http.delete(
    apiEnrole + '/$id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
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