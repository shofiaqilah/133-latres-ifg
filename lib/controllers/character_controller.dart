import 'package:get/get.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class CharacterController extends GetxController {
  // buat object service API
  final ApiService _apiService = ApiService();

  // list reactive untuk simpan data karakter
  final RxList<Character> characters = <Character>[].obs;
  final RxBool isLoading = false.obs; // ini buat nampilin loading spnner
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCharacters(); // fetch data dari API
  }

  // ambil data character dari API
  Future<void> fetchCharacters() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final data = await _apiService
          .fetchCharacters(); // panggl service API untuk ambil data
      characters.assignAll(data); // pake assignAll karna pake RxList
    } catch (e) {
      errorMessage.value = 'Failed to load characters: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
