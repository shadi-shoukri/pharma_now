import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class SupabaseService {
  // منع إنشاء instance جديد من خارج الكلاس
  SupabaseService._();

  // instance واحدة ثابتة للكل
  static final SupabaseService instance = SupabaseService._();

  // الـ client الذي تستخدمه كل الـ features
  SupabaseClient get client => Supabase.instance.client;

  // تُستدعى مرة واحدة فقط في main.dart
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );
  }
}
