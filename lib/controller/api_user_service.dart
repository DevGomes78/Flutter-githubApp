import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/github_user_models.dart';

class ApiController extends ChangeNotifier{
  var baseUrl = 'https://api.github.com/users/DevGomes78';
  var decodeJson;

  Future <Map<String,dynamic>> getUser()async{
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);
    if(response.statusCode==200){
       decodeJson = jsonDecode(response.body);
     notifyListeners();
  return decodeJson;
    } else {
      throw Exception('erro');
    }
    }

  }
