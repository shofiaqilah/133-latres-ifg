import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:latres_ifg/controllers/spell_controller.dart';
import 'package:latres_ifg/models/spell.dart';
import 'package:latres_ifg/services/session_service.dart';
import 'package:latres_ifg/views/widgets/app_bottom_nav.dart';

class SpellView extends GetView<SpellController> {
  const SpellView({super.key});

  Future<void> _logout() async {
    await SessionService.logout();

    Get.snackbar(
      'Success!',
      'Logged out successfully',
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );

    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Spells Gallery'),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.toNamed('/favorite-spells'),
            tooltip: 'Favorite Spells',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchSpells,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.spells.length,
          itemBuilder: (context, index) {
            final spell = controller.spells[index];
            return _SpellListTile(spell: spell);
          },
        );
      }),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }
}

class _SpellListTile extends GetView<SpellController> {
  final Spell spell;

  const _SpellListTile({required this.spell});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final fav = controller.isFavorite(spell);

      return ListTile(
        leading: const Icon(Icons.auto_fix_high),
        title: Text(
          spell.spell,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(spell.use),
        trailing: IconButton(
          icon: Icon(
            fav ? Icons.favorite : Icons.favorite_border,
            color: fav ? Colors.red : Colors.grey,
          ),
          onPressed: () => controller.toggleFavorite(spell),
        ),
      );
    });
  }
}
