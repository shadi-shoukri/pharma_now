import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../features/auth/views/pages/splash_page.dart';
import '../features/auth/views/pages/login_page.dart';
import '../features/auth/controllers/auth_controller.dart';

class AppRoutes {
  static const splash       = '/';
  static const login        = '/login';
  static const patientHome  = '/patient/home';
  static const pharmacyHome = '/pharmacy/home';
  static const driverHome   = '/driver/home';
  static const adminHome    = '/admin/home';

  static final pages = [
    GetPage(name: splash,      page: () => const SplashPage()),
    GetPage(name: login,       page: () => const LoginPage()),

    // صفحات مؤقتة حتى يبني الفريق الـ frontend
    GetPage(name: patientHome,  page: () => _tempPage('patient')),
    GetPage(name: pharmacyHome, page: () => _tempPage('pharmacist')),
    GetPage(name: driverHome,   page: () => _tempPage('driver')),
    GetPage(name: adminHome,    page: () => _tempPage('admin')),
  ];

  // صفحة مؤقتة تعرض الدور فقط
  static Widget _tempPage(String role) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('✅ تسجيل الدخول نجح', style: TextStyle(fontSize: 20)),
          SizedBox(height: 16),
          Text('الدور: $role', style: TextStyle(fontSize: 16)),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Get.find<AuthController>().signOut(),
            child: Text('تسجيل خروج'),
          ),
        ],
      ),
    ),
  );
}
