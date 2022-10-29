import 'package:flutter/material.dart';
import 'package:flutter_github_app/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'controller/followers_controller.dart';
import 'controller/repository_controller.dart';
import 'controller/user_controller.dart';

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
  ChangeNotifierProvider(create: (context)=>UserController()),
  ChangeNotifierProvider(create: (context)=>RepositoryController()),
  ChangeNotifierProvider(create: (context)=>FolowersController()),
],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark
        ),
        home: const SplashPage(),
      ),
    );
  }
}

