import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/failure.dart';
import '../../../core/utils/constants.dart';
import '../../../app/routes.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {

  final _service = AuthService();

  // ── State ──────────────────────────────────────
  // Rx = reactive = عند تغيير القيمة، الـ UI يتحدث تلقائياً
  // مثل LiveData في Android

  final currentUser = Rxn<UserModel>();  // null = لم يسجّل بعد
  final isLoading   = false.obs;         // false = مش loading
  final errorMsg    = ''.obs;            // '' = لا يوجد خطأ

  // controllers للـ TextFields في الـ UI
  final emailCtrl    = TextEditingController();
  final passwordCtrl = TextEditingController();

  // ── onClose — مثل destroy() في Java ───────────
  // يُستدعى عند إغلاق الـ Controller — حرر الذاكرة
  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }

  // ── تسجيل دخول ────────────────────────────────
  Future<void> signIn() async {

    errorMsg.value = '';  // امسح الخطأ السابق

    // validation بسيط
    if (emailCtrl.text.trim().isEmpty || passwordCtrl.text.isEmpty) {
      errorMsg.value = 'يرجى ملء جميع الحقول';
      return;  // أوقف التنفيذ هنا — مثل Java
    }

    isLoading.value = true;  // أظهر loading

    try {

      final user = await _service.signIn(
        emailCtrl.text.trim(),
        passwordCtrl.text,
      );

      currentUser.value = user;   // احفظ المستخدم في الـ State
      _goToHome(user.role);       // وجّه حسب الدور

    } on AppException catch (e) {
      // حوّل الخطأ التقني لرسالة مفهومة
      errorMsg.value = Failure.fromException(e).userMessage;

    } finally {
      // يُنفَّذ دائماً — سواء نجح أو فشل — نفس Java
      isLoading.value = false;
    }
  }

  // ── توجيه حسب الدور ───────────────────────────
  void _goToHome(String role) {
    // offAllNamed = اذهب وامسح كل تاريخ التنقل
    // المستخدم لا يستطيع الرجوع لصفحة Login
    switch (role) {
      case AppConstants.rolePatient:
        Get.offAllNamed(AppRoutes.patientHome);
        break;
      case AppConstants.rolePharmacist:
        Get.offAllNamed(AppRoutes.pharmacyHome);
        break;
      case AppConstants.roleDriver:
        Get.offAllNamed(AppRoutes.driverHome);
        break;
      case AppConstants.roleAdmin:
        Get.offAllNamed(AppRoutes.adminHome);
        break;
      default:
        errorMsg.value = 'دور غير معروف، تواصل مع الدعم';
    }
  }

  // ── تسجيل خروج ────────────────────────────────
  Future<void> signOut() async {
    await _service.signOut();
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }

  // ── فحص Session عند فتح التطبيق ───────────────
  // تُستدعى من SplashPage
  Future<void> checkSession() async {
    isLoading.value = true;

    final user = await _service.getCurrentUser();

    if (user != null) {
      currentUser.value = user;
      _goToHome(user.role);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }

    isLoading.value = false;
  }
}
