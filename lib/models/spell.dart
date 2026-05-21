// pake hive buat nyimpen data spell fav

import 'package:hive/hive.dart';
part 'spell.g.dart';

@HiveType(typeId: 0)
class Spell extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String spell;

  @HiveField(2)
  final String use;

  @HiveField(3)
  bool isFavorite = false;

  Spell({required this.id, required this.spell, required this.use});

  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      id: json['index'],
      spell: json['spell'] ?? '',
      use: json['use'] ?? '',
    );
  }
}
