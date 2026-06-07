import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/utils/constants.dart';
import '../models/user_model.dart';

class AuthService {

  // يأخذ الـ client الجاهز — لا ينشئ اتصالاً جديداً
  final _client = SupabaseService.instance.client;

  // ─── تسجيل دخول ──────────────────────────────
  Future<UserModel> signIn(String email, String password) async {
    try {

      // ١. تسجيل الدخول — Supabase يتحقق من الإيميل وكلمة المرور
      final response = await _client.auth.signInWithPassword(
        email:    email,
        password: password,
      );

      // ٢. إذا فشل — response.user يكون null
      if (response.user == null) {
        throw AppException(
          message: 'لم يُرجع Supabase أي مستخدم',
          type: ExceptionType.auth,
        );
      }

      // ٣. اجلب الدور من جدول profiles
      //    مثل: SELECT * FROM profiles WHERE id = ? LIMIT 1
      final profile = await _client
      .from(AppConstants.tableProfiles)   // FROM profiles
      .select()                            // SELECT *
      .eq('id', response.user!.id)        // WHERE id = ?
      .single();                           // LIMIT 1

      // ٤. حوّل النتيجة إلى UserModel وأرجعها
      return UserModel.fromJson({
        'id':        response.user!.id,
        'email':     response.user!.email ?? '',
        'role':      profile['role'],
        'full_name': profile['full_name'],
      });

    } on AuthException catch (e) {
      // خطأ من Supabase Auth — إيميل خاطئ أو كلمة مرور خاطئة
      throw AppException(
        message: e.message,
        type:    ExceptionType.auth,
        code:    e.statusCode,
      );
    } on PostgrestException catch (e) {
      // خطأ من قاعدة البيانات — مثلاً profile غير موجود
      throw AppException(
        message: e.message,
        type:    ExceptionType.server,
        code:    e.code,
      );
    } catch (e) {
      // أي خطأ آخر غير متوقع
      throw AppException(
        message: e.toString(),
        type:    ExceptionType.unknown,
      );
    }
  }

  // ─── هل يوجد session نشط؟ ────────────────────
  // تُستدعى عند فتح التطبيق — هل المستخدم مسجّل مسبقاً؟
  Future<UserModel?> getCurrentUser() async {
    try {
      final session = _client.auth.currentSession;

      // لا يوجد session = لم يسجّل دخول بعد
      if (session == null) return null;

      // يوجد session = اجلب بياناته من profiles
      final profile = await _client
      .from(AppConstants.tableProfiles)
      .select()
      .eq('id', session.user.id)
      .single();

      return UserModel.fromJson({
        'id':        session.user.id,
        'email':     session.user.email ?? '',
        'role':      profile['role'],
        'full_name': profile['full_name'],
      });

    } catch (_) {
      // أي خطأ = اعتبره غير مسجّل
      return null;
    }
  }

  // ─── تسجيل خروج ──────────────────────────────
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw AppException(
        message: e.toString(),
        type:    ExceptionType.server,
      );
    }
  }
}
