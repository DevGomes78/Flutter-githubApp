import 'package:flutter/material.dart';
import 'package:flutter_github_app/components/popular_text_list.dart';
import '../components/botton_bar.dart';
import '../components/bottonnavigationBar.dart';
import '../components/list_repository.dart';
import '../components/top_bar.dart';
class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopBar(),
            const SizedBox(height: 10),
            const popularTextList(),
            const SizedBox(height: 15),
            const ListRepository(),
            const SizedBox(width: 10),
            bottonBar(context),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}



