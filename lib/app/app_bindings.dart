import 'package:get/get.dart';
import '../features/auth/controllers/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // put بدل lazyPut — ينشئه فوراً ويبقيه حياً
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
