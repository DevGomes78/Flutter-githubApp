import 'package:flutter/material.dart';
import 'package:flutter_github_app/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'service/followers_service.dart';
import 'service/repository_service.dart';
import 'service/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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

