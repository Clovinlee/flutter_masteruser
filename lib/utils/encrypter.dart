import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String encrypt(String s) {
  String encrypted = "";
  final key = Key.fromUtf8(dotenv.env["APP_KEY"]!.substring(0, 32));
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  encrypted = encrypter.encrypt(s, iv: iv).base64;
  return encrypted;
}

String decrypt(String s) {
  String decrypted = "";
  final key = Key.fromUtf8(dotenv.env["APP_KEY"]!.substring(0, 32));
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  decrypted = encrypter.decrypt64(s, iv: iv);
  return decrypted;
}
