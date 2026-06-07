import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'app_bindings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PharmaFlow',
      debugShowCheckedModeBanner: false,

      // نقطة البداية
      initialRoute: AppRoutes.splash,

      // خريطة الصفحات
      getPages: AppRoutes.pages,

      // حقن الـ Controllers
      initialBinding: AppBindings(),

      // اللغة العربية
      locale: const Locale('ar'),
      textDirection: TextDirection.rtl,
    );
  }
}
