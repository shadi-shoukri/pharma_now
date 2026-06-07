import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    // Get.find = اجلب الـ Controller الذي سجّله AppBindings
    final ctrl = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                'تسجيل الدخول',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 32),

              // حقل الإيميل
              TextField(
                controller: ctrl.emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'الإيميل',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 16),

              // حقل كلمة المرور
              TextField(
                controller: ctrl.passwordCtrl,
                obscureText: true,   // يخفي النص
                decoration: const InputDecoration(
                  labelText: 'كلمة المرور',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 16),

              // رسالة الخطأ — تظهر فقط عند وجود خطأ
              Obx(() {
                if (ctrl.errorMsg.value.isEmpty) {
                  return const SizedBox.shrink(); // لا شيء
                }
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ctrl.errorMsg.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }),

              const SizedBox(height: 24),

              // زر الدخول — يتغير حسب isLoading
              Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  // إذا isLoading = true، أوقف الزر
                  onPressed: ctrl.isLoading.value ? null : ctrl.signIn,
                  child: ctrl.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('دخول', style: TextStyle(fontSize: 16)),
                ),
              )),

            ],
          ),
        ),
      ),
    );
  }
}
