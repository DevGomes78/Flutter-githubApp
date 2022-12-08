import 'package:flutter/material.dart';

import '../constants/string_constants.dart';
import '../controller/call_repository_controller.dart';
import '../models/repository_model.dart';
import '../service/repository_service.dart';

class SearcRepository extends SearchDelegate{

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<RepositoyModels>>(
        future: RepositoryController().searchRepository(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var listRepository = snapshot.data![index];
                  return InkWell(
                    onTap: CallRepository(repositoyModels: listRepository).callGithub,
                    child: Card(
                      elevation: 5,
                      child: SizedBox(
                        height: 110,
                        width: 220,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listRepository.name.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                listRepository.description.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
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
                });
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return  Center(
      child: Text(
        StringConstants.searchRepository,
        style: TextStyle(fontSize: 22),
      ),
    );
  }

}