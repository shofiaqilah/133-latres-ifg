import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({super.key, required this.currentIndex});

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
