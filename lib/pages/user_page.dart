import 'package:flutter/material.dart';
import '../components/botton_bar.dart';
import '../components/bottonnavigationBar.dart';
import '../components/top_bar.dart';
import 'package:provider/provider.dart';
import '../constants/error_constants.dart';
import '../constants/string_constants.dart';
import '../controller/repository_controller.dart';
import '../controller/user_controller.dart';
import '../controller/call_repository.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  RepositoryController controller = RepositoryController();

  @override
  void initState() {
    controller = context.read<RepositoryController>();

    controller.getPopular();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerRepository = Provider.of<RepositoryController>(context);

    return Scaffold(
      backgroundColor: Colors.black26,
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: UserController().getUser(),
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
                  return Column(
                    children: [
                      const TopBar(),
                      const SizedBox(height: 10),
                      _textPopularList(),
                      const SizedBox(height: 15),
                      providerRepository.list.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : _listRepository(providerRepository),
                      const SizedBox(width: 10),
                      bottonBar(context),
                    ],
                  );
                }
            }
          },
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}

_textPopularList() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: SizedBox(
      height: 25,
      child: Row(
        children: const [
          Icon(Icons.star_border, color: Colors.white, size: 30),
          SizedBox(width: 10),
          Text(
            StringConstants.popular,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

_listRepository(RepositoryController providerRepository) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: SizedBox(
      height: 180,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: providerRepository.list.length,
          itemBuilder: (context, index) {
            var listRepository = providerRepository.list[index];
            return InkWell(
              onTap: CallRepository(repositoyModels: listRepository).callGithub,
              child: Card(
                elevation: 5,
                child: SizedBox(
                  height: 230,
                  width: 280,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                  listRepository.owner!.avatarUrl.toString()),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              listRepository.owner!.login.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          listRepository.name.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(listRepository.description.toString()),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(listRepository.stargazersCount.toString()),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.lightBlue),
                            ),
                            const SizedBox(width: 10),
                            Text(listRepository.language.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    ),
  );
}




