import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/favourites_provider.dart';
import 'package:meals/provider/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

import 'package:meals/provider/filter_provider.dart';

import 'package:meals/model/meal.dart';

class Tabs extends ConsumerStatefulWidget {
  @override
  ConsumerState<Tabs> createState() => _TabsState();
}

class _TabsState extends ConsumerState<Tabs> {
  int _SelectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];

  var title = 'Categories';
  void _SelectedPage(idx) {
    setState(() {
      _SelectedPageIndex = idx;
    });
  }

  void setPage(String identifier) async {
    Navigator.pop(context);

    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favouriteMealsProvider);
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
      favouriteMeals: favoriteMeals,
    );
    if (_SelectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      title = 'Favourites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: MainDrawer(onpressed: setPage),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _SelectedPageIndex,
        onTap: _SelectedPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
