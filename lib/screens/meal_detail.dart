import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/model/meal.dart';
import 'package:meals/provider/favourites_provider.dart';
import 'package:riverpod/riverpod.dart';
// favourite star is updated but we need to go back and come again to see the change in color, as i should again build for update;

class MealDetail extends ConsumerWidget {
  const MealDetail({
    super.key,
    required this.mealItem,
  });

  final Meal mealItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favouriteMealsProvider
                      .notifier) //from the provider accessing the stateNotifier then accessing the function.
                  .toggleFavouriteMeals(mealItem);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'Meal Added as a Favourite'
                      : 'Meal Deleted from Favourite'),
                ),
              );
            },
            icon: Icon(
              Icons.star,
              color: favouriteMeals.contains(mealItem)
                  ? Colors.amber
                  : Colors.white,
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          mealItem.title,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                mealItem.imageUrl,
                height: 200,
                width: double.infinity,
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  'INGREDIENTS',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              ...mealItem.ingredients
                  .map(
                    (e) => Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Text(e, style: TextStyle(color: Colors.white))),
                  )
                  .toList(),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  'STEPS',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              ...mealItem.steps
                  .map((e) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text(e, style: TextStyle(color: Colors.white))))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
