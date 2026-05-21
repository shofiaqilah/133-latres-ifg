import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latres_ifg/models/spell.dart';
import 'package:latres_ifg/views/pages/login_view.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive untuk flutter
  await Hive.initFlutter();
  Hive.registerAdapter(SpellAdapter());

  // buka boc hive yang fikasih nama favorite_spells
  await Hive.openBox<Spell>('fav_spells');

  // Initialize notifications
  await NotificationService.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // karna ini pake GetX
      title: 'Harry Potter App',
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,

      // routes
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/characters', page: () => LoginView()),
        GetPage(name: '/detail-character', page: () => LoginView()),
        GetPage(name: '/spells', page: () => LoginView()),
        GetPage(name: '/fav-spell', page: () => LoginView()),
      ],
    );
  }
}
