import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/my_project_modesl.dart';


class ApiMyProject extends ChangeNotifier{
  List<MyProjectModels>list =[];
  Future <List<MyProjectModels>> getMyProject()async{
    var url = Uri.parse('https://api.github.com/users/DevGomes78/repos');
    var response = await http.get(url);
    if(response.statusCode==200){
      var decodeJson = jsonDecode(response.body);
      decodeJson.forEach((item)=> list.add(MyProjectModels.fromJson(item)));
      notifyListeners();
      return list;

    } else {
      throw Exception('erro');
    }
  }
}