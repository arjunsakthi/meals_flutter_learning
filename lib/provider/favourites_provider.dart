import 'package:riverpod/riverpod.dart';

import 'package:meals/model/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]); // initializing with an empty list.

  bool toggleFavouriteMeals(Meal meal) {
    final favouriteMeal = state.contains(meal);

    if (favouriteMeal) {
      state = state
          .where((m) => m.id != meal.id)
          .toList(); // updating State of StateNotifier
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
