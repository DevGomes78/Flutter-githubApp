import 'package:flutter/material.dart';
import 'package:flutter_github_app/pages/user_page.dart';
import 'package:provider/provider.dart';

import '../controller/user_controller.dart';

class SearchUser extends StatefulWidget {
  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  TextEditingController textControler = TextEditingController();

  Widget build(BuildContext context) {
    UserController provider = Provider.of<UserController>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'nome',
                  hintText: 'Digite o nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              controller: textControler,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                provider.getUser(textControler.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserPage(
                              text: textControler.text,
                            )));
              },
              child: Container(
                alignment: Alignment.center,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                child: const Text('Procurar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
