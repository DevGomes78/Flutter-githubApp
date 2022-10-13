import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/folowers_models.dart';


class ApiFolowers extends ChangeNotifier{
  List<folowersModels>list =[];
  Future <List<folowersModels>> getFolowing()async{
    var url = Uri.parse('https://api.github.com/users/DevGomes78/followers');
    var response = await http.get(url);
    if(response.statusCode==200){
      var decodeJson = jsonDecode(response.body);
      decodeJson.forEach((item)=> list.add(folowersModels.fromJson(item)));
      notifyListeners();
      return list;

    } else {
      throw Exception('erro');
    }
  }
}