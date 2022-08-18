import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserDetailsModel {
  final int id;
  final String email;
  final String? name;

  UserDetailsModel({
    required this.id,
    required this.email,
    this.name,
  });

  UserDetailsModel copyWith({
    int? id,
    String? email,
    String? name,
  }) {
    return UserDetailsModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
    };
  }

  factory UserDetailsModel.fromMap(Map<String, dynamic> map) {
    return UserDetailsModel(
      id: map['id'] as int,
      email: map['email'] as String,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailsModel.fromJson(String source) =>
      UserDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
