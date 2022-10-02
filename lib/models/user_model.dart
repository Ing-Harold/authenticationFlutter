// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class User {
  User({
    required this.nombre,
    required this.email,
  });

  final String nombre;
  final String email;

  User copyWith({
    String? nombre,
    String? email,
  }) =>
      User(
        nombre: nombre ?? this.nombre,
        email: email ?? this.email,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        nombre: json["nombre"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "email": email,
      };
}
