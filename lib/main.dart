import 'package:flutter/material.dart';
import 'package:flutter_github_app/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'controller/apiFollowers.dart';
import 'controller/api_repository.dart';
import 'controller/api_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
providers: [
  ChangeNotifierProvider(create: (context)=>ApiUserController()),
  ChangeNotifierProvider(create: (context)=>ApiRepository()),
  ChangeNotifierProvider(create: (context)=>ApiFolowers()),
],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark
        ),
        home: const HomePage(),
      ),
    );
  }
}

