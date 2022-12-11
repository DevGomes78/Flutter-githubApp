import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/call_repository_controller.dart';
import '../service/repository_service.dart';

class ListRepository extends StatefulWidget {
  String? text;

  ListRepository(this.text, {Key? key}) : super(key: key);

  @override
  State<ListRepository> createState() => _ListRepositoryState();
}

class _ListRepositoryState extends State<ListRepository> {
  RepositoryController controller = RepositoryController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    controller = context.read<RepositoryController>();
    controller.getRepository(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RepositoryController>(context);
    if (provider.lista.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return _repositoryList(provider);
    }
  }

  _repositoryList(provider) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.lista.length,
            itemBuilder: (context, index) {
              var listRepository = provider.lista[index];
              return InkWell(
                onTap:
                    CallRepository(repositoyModels: listRepository).callGithub,
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
                          Text(
                            listRepository.description.toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 25),
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
}
