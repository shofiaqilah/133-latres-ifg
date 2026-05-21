// bikin service hive
import 'package:hive/hive.dart';

import '../models/spell.dart';
// class fav spell, karena itu yg disimpen di hive
class FavSpellService {
  static const String _boxName = 'fav_spells';

  static Future<Box<Spell>> _getBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<Spell>(_boxName);
    }

    return Hive.openBox<Spell>(_boxName);
  }

  static Future<List<Spell>> getFavorites() async {
    final box = await _getBox();
    return box.values.toList();
  }

  static Future<bool> isFavorite(int id) async {
    final box = await _getBox();
    return box.containsKey(id);
  }

  static Future<void> addFavorite(Spell spell) async {
    final box = await _getBox();
    await box.put(spell.id, spell);
  }

  static Future<void> removeFavorite(Spell spell) async {
    final box = await _getBox();
    await box.delete(spell.id);
  }
}