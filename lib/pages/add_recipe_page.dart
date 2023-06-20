import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../db/database_service.dart';
import '../models/recipe.dart';
import 'components/input_resep.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({
    super.key,
    this.recipe,
  });

  final Recipe? recipe;

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? photo;
  late TextEditingController _nameController;
  late TextEditingController _ingredientsController;
  late TextEditingController _howToMakeController;
  DatabaseService dbService = DatabaseService();

  @override
  void initState() {
    _nameController = TextEditingController();
    _ingredientsController = TextEditingController();
    _howToMakeController = TextEditingController();

    if (widget.recipe != null) {
      _nameController.text = widget.recipe!.foodName;
      _ingredientsController.text = widget.recipe!.ingredients;
      _howToMakeController.text = widget.recipe!.howToMake;
      photo = XFile(widget.recipe!.image);
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ingredientsController.dispose();
    _howToMakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 25),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputResep(
                      hint: "Nama makanan",
                      controller: _nameController,
                    ),
                    InputResep(
                      controller: _ingredientsController,
                      hint: "Bahan-bahan",
                      isLarge: true,
                    ),
                    InputResep(
                      controller: _howToMakeController,
                      hint: "Cara membuat",
                      isLarge: true,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          )),
                      child: ListTile(
                        onTap: () async {
                          final picker = ImagePicker();
                          photo = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          setState(() {});
                        },
                        title: Text(photo?.name ?? "Upload Photo"),
                        trailing: photo == null
                            ? Icon(
                                Icons.image_outlined,
                                color: Theme.of(context).primaryColor,
                              )
                            : Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(
                                        photo!.path,
                                      ),
                                    ),
                                  ),
                                ),
                                width: 100,
                              ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            photo != null) {
                          Recipe recipe = Recipe(
                            _nameController.text,
                            _ingredientsController.text,
                            _howToMakeController.text,
                            DateTime.now(),
                            photo!.path,
                          );
                          if (widget.recipe != null) {
                            await dbService.editRecipe(
                                widget.recipe!.key, recipe);
                          } else {
                            await dbService.addRecipe(recipe);
                          }
                          if (!mounted) return;
                          GoRouter.of(context).pop();
                        } else if (photo == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              content: Text('Harap Upload Gambar'),
                            ),
                          );
                        }
                      },
                      child: const Text("Simpan"),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
