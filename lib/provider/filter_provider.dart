import 'package:meals/provider/meals_provider.dart';
import 'package:riverpod/riverpod.dart';

enum Filter {
  gluctenFree,
  lactosefree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.gluctenFree: false,
          Filter.lactosefree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void filerSet(Map<Filter, bool> updatedFilter) {
    state = updatedFilter;
  }

  void setFilter(Filter filter, bool ischecked) {
    state = {...state, filter: ischecked};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  // setting watcher here. so when ever watch value changes function gets reexecuted.
  // here we are getting ref as a parameter then using it to use watcher and reader.
  // ref means an reference object
  final meals = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilter[Filter.gluctenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilter[Filter.lactosefree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
