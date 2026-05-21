import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latres_ifg/models/spell.dart';

import '../models/character.dart';

class ApiService {
  static const String _baseUrl = 'https://potterapi-fedeperin.vercel.app/en';

  // fetch API untuk data karakter
  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$_baseUrl/characters'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  // ini yg spell
    // fetch API untuk data karakter
  Future<List<Spell>> fetchSpells() async {
    final response = await http.get(Uri.parse('$_baseUrl/spells'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Spell.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load spells');
    }
  }
}
