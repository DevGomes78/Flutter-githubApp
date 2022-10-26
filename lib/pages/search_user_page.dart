import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/string_constants.dart';
import 'package:flutter_github_app/pages/user_page.dart';
import 'package:provider/provider.dart';
import '../constants/service_constants.dart';
import '../controller/user_controller.dart';

class SearchUserPage extends StatefulWidget {
  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  TextEditingController textControler = TextEditingController();

  Widget build(BuildContext context) {
    UserController provider = Provider.of<UserController>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: _searchUser(provider, context),
    );
  }

  _searchUser(
    UserController provider,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 150),
            Image.asset(
              ServiceConstants.imageAsset,
              color: Colors.white,
              height: 180,
            ),
            const SizedBox(height: 150),
            const Text(
              StringConstants.enterGithubUser,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: StringConstants.user,
                  hintText: StringConstants.enterUser,
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
                child: const Text(StringConstants.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
