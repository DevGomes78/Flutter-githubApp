import 'package:flutter/material.dart';
import 'package:flutter_github_app/components/popular_text.dart';
import '../components/botton_card.dart';
import '../components/bottonnavigationBar.dart';
import '../components/card_list.dart';
import '../components/top_card.dart';
class UserPage extends StatefulWidget {
  String? text;
   UserPage({Key? key,this.text}) : super(key: key);


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
            TopCard(widget.text),
            const SizedBox(height: 10),
            const PopularTextList(),
            const SizedBox(height: 15),
             ListRepository(widget.text),
            const SizedBox(width: 10),
            BottonCard(widget.text),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}



