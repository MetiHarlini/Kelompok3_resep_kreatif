import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../db/database_service.dart';
import '../../models/recipe.dart';

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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Dismissible(
        key: Key(recipe.key.toString()),
        background: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.delete),
              Icon(Icons.delete),
            ],
          ),
        ),
        onDismissed: (_) {
          databaseService.deleteRecipe(recipe).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text('Resep berhasil dihapus'),
            ));
          });
        },
        child: InkWell(
          onTap: () {
            context.pushNamed("detail-recipe", extra: recipe);
          },
          child: Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xffFDBAA0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(recipe.image),
                    ),
                  )),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    recipe.foodName,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
