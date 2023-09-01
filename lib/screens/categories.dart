import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../model/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.favouriteMeals,
    required this.availableMeals,
  });
  final List<Meal> availableMeals;
  final List<Meal> favouriteMeals;

  void _selectedCategory(BuildContext context, Category category) {
    final fileteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: fileteredMeals,
        ),
      ),
    );
  }

  @override
  build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: availableCategories
          .map(
            (category) => CategoryGridItem(
              category: category,
              onSelectedCategoy: () {
                _selectedCategory(context, category);
              },
            ),
          )
          .toList(),
    );
  }
}
