import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/string_constants.dart';
import 'package:flutter_github_app/controller/followers_controller.dart';
import 'package:provider/provider.dart';

class FolowersPage extends StatefulWidget {
  String? text;

  FolowersPage(this.text, {Key? key}) : super(key: key);

  @override
  State<FolowersPage> createState() => _FolowersPageState();
}

class _FolowersPageState extends State<FolowersPage> {
  FolowersController controller = FolowersController();

  @override
  void initState() {
    controller = context.read<FolowersController>();
    controller.getFolowing(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<FolowersController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.folower),
      ),
      body: provider.list.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _folowersList(provider),
    );
  }

  _folowersList(provider) {
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
