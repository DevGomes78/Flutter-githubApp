import 'dart:convert';
import 'package:flutter_github_app/constants/service_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../constants/error_constants.dart';
import '../models/folowers_models.dart';

class ApiFolowers extends ChangeNotifier {
  List<folowersModels> list = [];

  Future<List<folowersModels>> getFolowing() async {
    try {
      var url = Uri.parse(ServiceConstants.folowersService);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => list.add(folowersModels.fromJson(item)));
        return list;
      }
    } catch (e) {
      print('${ErrorConstants.erroAoAcessarPagina}$e');
    }
    return [];
  }
}
