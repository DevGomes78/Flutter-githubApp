import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/service_constants.dart';
import 'package:provider/provider.dart';
import '../constants/error_constants.dart';
import '../constants/string_constants.dart';
import '../controller/user_controller.dart';
import '../pages/repository_list_page.dart';

class BottonCard extends StatefulWidget {
String? text;
BottonCard(this.text, {Key? key}) : super(key: key);

  @override
  State<BottonCard> createState() => _BottonCardState();
}

class _BottonCardState extends State<BottonCard> {
  UserController controller = UserController();

  @override
  void initState() {
    controller = context.read<UserController>();

    controller.getUser(widget.text);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserController provider = Provider.of<UserController>(context);
    return FutureBuilder<Map<String, dynamic>>(
        future: UserController().getUser(widget.text),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(ErrorConstants.errorPage),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 5,
                    child: SizedBox(
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.receipt,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 20),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RepositoryList(widget.text)));
                                  },
                                  child: const Text(
                                    StringConstants.repository,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 150),
                                Text(
                                    provider.decodeJson[
                                            ServiceConstants.publicRepository]
                                        .toString(),
                                    style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: const [
                                Icon(Icons.dataset_outlined,
                                    color: Colors.orange),
                                SizedBox(width: 20),
                                Text(
                                  StringConstants.organizations,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(width: 135),
                                Text(
                                  '0',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: const [
                                Icon(Icons.star, color: Colors.yellow),
                                SizedBox(width: 15),
                                Text(
                                  StringConstants.ratedAsStar,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  '17',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          }
        });
  }
}
