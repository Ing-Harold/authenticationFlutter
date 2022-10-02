import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fotografos/global/environment.dart';
import 'package:fotografos/models/models.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  User? user;
  final storage = const FlutterSecureStorage();

  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'usr_token');
    return token;
  }

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${Environment.apiUrl}/auth/register');
    final resp = await http.post(url, body: {
      'nombre': name,
      'email': email,
      'password': password,
    });
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (resp.statusCode == 200) {
      await storage.write(key: 'usr_token', value: decodedResp['user_token']);
      user = User.fromMap(decodedResp);
      return null;
    } else {
      return decodedResp['message'];
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final url =
        Uri.https(Environment.baseUrl, '${Environment.path}/auth/login', {
      'email': email,
      'password': password,
    });
    final resp = await http.get(url);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (resp.statusCode == 200) {
      await storage.write(key: 'usr_token', value: decodedResp['user_token']);
      user = User.fromMap(decodedResp);
      return null;
    } else {
      return decodedResp['message'];
    }
  }

  Future loguot() async {
    await storage.delete(key: 'usr_token');
    user = null;
    return;
  }

  Future<bool> isLogged() async {
    final usrToken = await storage.read(key: 'usr_token');
    if (usrToken == null) return false;
    final url = Uri.https(Environment.baseUrl,
        '${Environment.path}/auth/checklogin', {'user_token': usrToken});
    final resp = await http.get(url);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (resp.statusCode == 200) {
      await storage.write(key: 'usr_token', value: decodedResp['user_token']);
      user = User.fromMap(decodedResp);
      return true;
    } else {
      return false;
    }
  }
}
