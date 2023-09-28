import 'dart:convert';
import 'package:crypto/crypto.dart';

// ignore: non_constant_identifier_names
String HashPassword(String password) {
  const salt = 'doyatama';
  final bytes = utf8.encode(password + salt);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
