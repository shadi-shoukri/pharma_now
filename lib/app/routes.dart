import 'package:get/get.dart';
import '../features/auth/views/pages/splash_page.dart';
import '../features/auth/views/pages/login_page.dart';

class AppRoutes {
  static const splash       = '/';
  static const login        = '/login';
  static const patientHome  = '/patient/home';
  static const pharmacyHome = '/pharmacy/home';
  static const driverHome   = '/driver/home';
  static const adminHome    = '/admin/home';

  static final pages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: login,  page: () => const LoginPage()),
    // باقي الصفحات تضيفها عند بناء كل feature
  ];
}
