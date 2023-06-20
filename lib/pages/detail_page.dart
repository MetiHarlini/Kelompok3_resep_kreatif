import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:resep_kreatif/extensions/format_date.dart';
import '../db/database_service.dart';
import '../models/recipe.dart';

class DetaiRecipelPage extends StatefulWidget {
  final Recipe recipe;
  const DetaiRecipelPage({super.key, required this.recipe});

  @override
  State<DetaiRecipelPage> createState() => _DetailRecipePageState();
}

class _DetailRecipePageState extends State<DetaiRecipelPage> {
  DatabaseService dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFC7643),
        elevation: 5,
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          height: 100,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.file(
              File(widget.recipe.image),
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.63,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              widget.recipe.foodName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat("EEEE, dd MMMM yyyy", "id_ID")
                                  .format(widget.recipe.createdAt),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: const Text(
                                  "Bahan bahan",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(widget.recipe.ingredients),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: const Text(
                                  "Cara Membuat",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(widget.recipe.howToMake),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          GoRouter.of(context)
              .pushReplacementNamed('add-recipe', extra: widget.recipe);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    required this.databaseService,
  });

  final Recipe recipe;
  final DatabaseService databaseService;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(recipe.key.toString()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xffFDBAA0),
          ),
          child: ListTile(
            title: Text(
              recipe.foodName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(recipe.ingredients),
            trailing: Text('Dibuat pada:\n ${recipe.createdAt.formatDate()}'),
          ),
        ),
      ),
    );
  }
}

//subtitle: Text(recipe.ingredients),
//trailing: Text('Dibuat pada:\n ${recipe.createdAt.formatDate()}'),
