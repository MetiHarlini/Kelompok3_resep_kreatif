import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe extends HiveObject {
  @HiveField(0)
  late String foodName;

  @HiveField(1)
  late String ingredients;

  @HiveField(2)
  late String howToMake;

  @HiveField(3)
  late DateTime createdAt;

  @HiveField(4)
  late String image;

  Recipe(
    this.foodName,
    this.ingredients,
    this.howToMake,
    this.createdAt,
    this.image,
  );
}
