import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:latres_ifg/controllers/spell_controller.dart';
import 'package:latres_ifg/models/spell.dart';

class FavoriteSpellView extends GetView<SpellController> {
  const FavoriteSpellView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Spell'),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.favoriteSpells.isEmpty) {
          return const Center(
            child: Text(
              'No favorite spells yet.\nGo add some!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.favoriteSpells.length,
          itemBuilder: (context, index) {
            final spell = controller.favoriteSpells[index];
            return _FavoriteSpellTile(spell: spell);
          },
        );
      }),
    );
  }
}

class _FavoriteSpellTile extends GetView<SpellController> {
  final Spell spell;

  const _FavoriteSpellTile({required this.spell});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.auto_fix_high),
      title: Text(
        spell.spell,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(spell.use),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () async {
          await controller.removeFavorite(spell);
        },
      ),
    );
  }
}
