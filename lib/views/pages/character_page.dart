import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/character_controller.dart';
import '../../models/character.dart';
import 'package:latres_ifg/services/session_service.dart';

// halaman ini pake CharacterController
class CharacterView extends GetView<CharacterController> {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Characters'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await SessionService.logout();
              Get.offAllNamed('/login');
            },
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
                  onPressed: controller.fetchCharacters,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.characters.length, // ambil semua characters
          itemBuilder: (context, index) {
            final character = controller.characters[index];

            /// character = ambil satu character berdasarkan index
            return _CharacterListTile(character: character);
          },
        );
      }),
      bottomNavigationBar: _BottomNav(currentIndex: 0),
    );
  }
}

// ini widget untuk tiap item list
class _CharacterListTile extends StatelessWidget {
  final Character character; // satu ibejk charcter

  const _CharacterListTile({
    required this.character,
  }); // ini kiriman dari controller tadi

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          character.image,
          width: 48,
          height: 48,
          fit: BoxFit.cover,

          // tampilan sementara pas gambar masih loading
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
      title: Text(
        character.fullName, // ini nama karakter
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(character.interpretedBy), // nama pemain
      // satu tile kalo di tap lgsg masuk ke halaman detail
      // bawa arguments untuk character yg diklik
      onTap: () => Get.toNamed('/character-detail', arguments: character),
    );
  }
}

// bottom nav untuk pindah antara character dan spells
class _BottomNav extends StatelessWidget {
  final int currentIndex;

  const _BottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0 && currentIndex != 0) {
          Get.offNamed('/characters');
        } else if (index == 1 && currentIndex != 1) {
          Get.offNamed('/spells');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Characters'),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_fix_high),
          label: 'Spells',
        ),
      ],
    );
  }
}
