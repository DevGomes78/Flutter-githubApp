import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/string_constants.dart';
import 'package:flutter_github_app/controller/followers_controller.dart';
import 'package:provider/provider.dart';

class FolowersPage extends StatefulWidget {
  const FolowersPage({Key? key}) : super(key: key);

  @override
  State<FolowersPage> createState() => _FolowersPageState();
}

class _FolowersPageState extends State<FolowersPage> {
  FolowersController folowersController = FolowersController();

  @override
  void initState() {
    folowersController = context.read<FolowersController>();
    folowersController.getFolowing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FolowersController provider = Provider.of<FolowersController>(context);
    return Scaffold(
  appBar: AppBar(
    title: const Text(StringConstants.folower),
  ),
      body: provider.list.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : folowerList(provider),
    );
  }

  folowerList(provider) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListView.builder(
        itemCount: provider.list.length,
        itemBuilder: (context, index) {
          var lista = provider.list[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(lista.avatarUrl.toString()),
              ),
              title: Text(lista.login.toString()),
            ),
          );
        },
      ),
    );
  }

}
