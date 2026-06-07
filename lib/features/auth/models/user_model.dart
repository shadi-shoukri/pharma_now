class UserModel {
  final String  id;
  final String  email;
  final String  role;
  final String? fullName;  // ? = nullable مثل String? في Kotlin

  UserModel({
    required this.id,
    required this.email,
    required this.role,
    this.fullName,         // اختياري — ممكن null
  });

  // مثل: static User fromResultSet(ResultSet rs) في Java
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:       json['id']        as String,
      email:    json['email']     as String,
      role:     json['role']      as String,
      fullName: json['full_name'] as String?,
    );
  }

  // مثل: toMap() في Java — عند الإرسال لـ Supabase
  Map<String, dynamic> toJson() => {
    'id':        id,
    'email':     email,
    'role':      role,
    'full_name': fullName,
  };
}
