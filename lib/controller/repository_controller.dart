import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../constants/error_constants.dart';
import '../models/repository_model.dart';

class RepositoryController extends ChangeNotifier {
  List<RepositoyModels> list = [];
  List<RepositoyModels> lista = [];
  Future<List<RepositoyModels>> getRepository(String? user) async {
    try {
      var url = Uri.parse('https://api.github.com/users/$user/repos');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => list.add(RepositoyModels.fromJson(item)));
        lista = list.where((item) => item.stargazersCount! >= 1).toList();
        notifyListeners();
        return list;
      }
    } catch (e) {
      print('${ErrorConstants.erroAoAcessarPagina}$e');
      return lista;
    }
    return [];
  }
}
