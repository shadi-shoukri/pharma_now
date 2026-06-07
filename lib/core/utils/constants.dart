class AppConstants {
  // أسماء الجداول — إذا تغيرت في Supabase تغيرها هنا فقط
  static const String tableProfiles  = 'profiles';
  static const String tableMedicines = 'medicines';
  static const String tableOrders    = 'orders';
  static const String tableMessages  = 'messages';
  static const String tableDeliveries = 'deliveries';

  // أدوار المستخدمين
  static const String rolePatient    = 'patient';
  static const String rolePharmacist = 'pharmacist';
  static const String roleDriver     = 'driver';
  static const String roleAdmin      = 'admin';

  // أحوال الطلب
  static const String orderPending   = 'pending';
  static const String orderConfirmed = 'confirmed';
  static const String orderDelivered = 'delivered';
}
