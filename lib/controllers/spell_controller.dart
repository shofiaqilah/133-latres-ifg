import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latres_ifg/services/hive_service.dart';

import '../models/spell.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';

class SpellController extends GetxController {
  final ApiService _apiService = ApiService();

  final RxList<Spell> spells = <Spell>[].obs;
  final RxList<Spell> favoriteSpells = <Spell>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
    fetchSpells();
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavSpellService.getFavorites();
    favoriteSpells.assignAll(favorites);
  }

  Future<void> fetchSpells() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final data = await _apiService.fetchSpells();
      spells.assignAll(data);
    } catch (e) {
      errorMessage.value = 'Failed to load spells: $e';
    } finally {
      isLoading.value = false;
    }
  }

  bool isFavorite(Spell spell) {
    return favoriteSpells.any((s) => s.id == spell.id);
  }

  Future<void> toggleFavorite(Spell spell) async {
    if (isFavorite(spell)) {
      await FavSpellService.removeFavorite(spell);
      favoriteSpells.removeWhere((s) => s.id == spell.id);

      Get.snackbar(
        'Removed!',
        '${spell.spell} removed from the fav list!',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else {
      await FavSpellService.addFavorite(spell);
      favoriteSpells.add(spell);

      Get.snackbar(
        'Add!',
        '${spell.spell} successfully added to the fav list!',
        backgroundColor: Colors.green.withOpacity(0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> removeFavorite(Spell spell) async {
    await FavSpellService.removeFavorite(spell);
    favoriteSpells.removeWhere((s) => s.id == spell.id);

    await NotificationService.showDeleteNotification(spell.spell);
  }
}
