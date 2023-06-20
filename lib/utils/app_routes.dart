import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resep_kreatif/models/recipe.dart';

import '../pages/add_recipe_page.dart';
import '../pages/detail_page.dart';
import '../pages/home_page.dart';
import '../pages/splash_page.dart';

class AppRoutes {
  static const home = 'home';
  static const addRecipe = 'add-recipe';
  static const editRecipe = 'edit-recipe';
  static const detailRecipe = 'detail-recipe';
  static const splash = "splash";

  static Page _splahScreenBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(
      child: SplashPage(),
    );
  }

  static Page _homePageBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(
      child: HomePage(),
    );
  }

  static Page _addRecipePageBuilder(BuildContext context, GoRouterState state) {
    if (state.extra == null) {
      return const MaterialPage(child: AddRecipePage());
    } else {
      Recipe? recipe = state.extra as Recipe;
      return MaterialPage(
        child: AddRecipePage(
          recipe: recipe,
        ),
      );
    }
  }

  static Page _editRecipePageBuilder(
      BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: AddRecipePage(
        recipe: state.extra as Recipe,
      ),
    );
  }

  static Page _detailRecipePageBuilder(
      BuildContext context, GoRouterState state) {
    final Recipe resipe = state.extra as Recipe;
    return MaterialPage(
      child: DetaiRecipelPage(
        recipe: resipe,
      ),
    );
  }

  static GoRouter goRouter = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: splash,
        pageBuilder: _splahScreenBuilder,
      ),
      GoRoute(
        path: "/home",
        name: home,
        pageBuilder: _homePageBuilder,
        routes: [
          GoRoute(
            path: "add-recipe",
            name: addRecipe,
            pageBuilder: _addRecipePageBuilder,
          ),
          GoRoute(
            path: "edit-recipe",
            name: editRecipe,
            pageBuilder: _editRecipePageBuilder,
          ),
          GoRoute(
            path: "detail-recipe",
            name: detailRecipe,
            pageBuilder: _detailRecipePageBuilder,
          ),
        ],
      ),
    ],
  );
}
