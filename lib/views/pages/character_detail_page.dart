import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/character.dart';

// ga pake controller karna data dikirim dari page sebelumnya
class CharacterDetailView extends StatelessWidget {
  const CharacterDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // ambil data yg dikirim lwt argumrnts
    final Character character = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.fullName),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Character image
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(
                character.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 48,
                    height: 48,
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    'Full Name',
                    character.fullName,
                  ), // ini panggil atribut untuk character yg dibawa
                  _buildInfoRow('Nickname', character.nickname),
                  _buildInfoRow('Hogwarts House', character.hogwartsHouse),
                  _buildInfoRow('Interpreted By', character.interpretedBy),
                  _buildInfoRow(
                    'Children',
                    character.children.isEmpty
                        ? 'None'
                        : character.children.join(', '),
                  ),
                  _buildInfoRow('Birthdate', character.birthdate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // eidget untuk info per character
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
