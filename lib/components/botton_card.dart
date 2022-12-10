import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/service_constants.dart';
import 'package:provider/provider.dart';
import '../constants/error_constants.dart';
import '../constants/string_constants.dart';
import '../service/user_service.dart';
import '../pages/repository_list_page.dart';

class BottonCard extends StatefulWidget {
  String text;

  BottonCard(this.text, {Key? key}) : super(key: key);

  @override
  State<BottonCard> createState() => _BottonCardState();
}

class _BottonCardState extends State<BottonCard> {
  UserController controller = UserController();

  @override
  void initState() {
    controller = context.read<UserController>();
    controller.getUser(context, widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: controller.getUser(context, widget.text),
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
                return _bottonCard(context);
              }
          }
        });
  }

  _bottonCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 5,
        child: SizedBox(
          height: 165,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white12),
                      child: const Icon(
                        Icons.receipt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RepositoryListPage(widget.text)));
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
                        controller.decodeJson[ServiceConstants.publicRepository]
                            .toString(),
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.orange),
                        child: const Icon(Icons.dataset_outlined,
                            size: 20, color: Colors.white)),
                    const SizedBox(width: 20),
                    const Text(
                      StringConstants.organizations,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(width: 135),
                    const Text(
                      '0',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.yellowAccent),
                        child: const Icon(
                          Icons.star_border,
                          color: Colors.white,
                          size: 20,
                        )),
                    const SizedBox(width: 15),
                    const Text(
                      StringConstants.ratedAsStar,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(width: 40),
                    const Text(
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
