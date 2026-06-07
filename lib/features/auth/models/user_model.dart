class UserModel {
  final String  id;
  final String  email;
  final String  role;
  final String? fullName;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
    this.fullName,         // اختياري — ممكن null json['price'] as double
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:       json['id']        as String,
      email:    json['email']     as String,
      role:     json['role']      as String,
      fullName: json['full_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id':        id,
    'email':     email,
    'role':      role,
    'full_name': fullName,
  };
}
