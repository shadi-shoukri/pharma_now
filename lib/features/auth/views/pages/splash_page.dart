import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {


    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().checkSession();
    });

    // ما يراه المستخدم أثناء الفحص
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أضف logo هنا لاحقاً
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('جاري التحقق...'),
          ],
        ),
      ),
    );
  }
}
