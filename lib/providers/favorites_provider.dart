import 'package:flutter_reference/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final isFav = state.contains(meal);

    if (isFav) {
      //removing a meal
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // adding a meal
      // pull out and keep the existing meals by the spread operator
      //and then adding meal to the list
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
