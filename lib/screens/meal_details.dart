import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/provider/favorites_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.title,
    required this.meal,
  });

  final String title;
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'Meal was added as a favorite'
                      : 'Meal was removed from favorites'),
                ),
              );
            },
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          )
        ],
      ),
      body: Column(
        children: [
          Image.network(
            meal.imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 32,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.2),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 8,
                ),
                for (final ingredient in meal.ingredients)
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    width: double.infinity,
                    child: Text(
                      ingredient,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'Steps',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.2),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 8,
                ),
                for (final step in meal.steps)
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    width: double.infinity,
                    child: Text(
                      '• $step',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                      textAlign: TextAlign.left,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
