import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../db/database_service.dart';
import 'components/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseService dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFC7643),
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          height: 150,
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(DatabaseService.boxName).listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('Tidak ada resep'),
            );
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: box.length,
              itemBuilder: (context, index) {
                final recipe = box.getAt(index);
                return RecipeCard(
                  recipe: recipe,
                  databaseService: dbService,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed('add-recipe');
        },
        backgroundColor: const Color(0xffFC7643),
        child: const Icon(Icons.add),
      ),
    );
  }
}
