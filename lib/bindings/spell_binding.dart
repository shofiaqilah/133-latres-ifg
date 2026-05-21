import 'package:get/get.dart';
import '../controllers/spell_controller.dart';

class SpellBinding extends Bindings {
  @override
  void dependencies() {
    // halaman spell buth SpellController
    Get.lazyPut<SpellController>(() => SpellController());
  }
}
