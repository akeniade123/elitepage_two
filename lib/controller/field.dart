import 'dart:math';
import '../Controller/fields.dart';
import 'package:encrypt/encrypt.dart';

Future<String> encrypt(String plainText, String key_) async {
  final key = Key.fromUtf8(key_);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return encrypted.base64;
}

Future<String> decrypt(String converted, String key_) async {
  final key = Key.fromUtf8(key_);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  final decrypted = encrypter.decrypt64(converted, iv: iv);
  return decrypted;
}

Future<String> generateKey() async {
  final buffer = StringBuffer('');
  for (int i = 0; i < 7; i++) {
    var alphaChar = Random().nextInt(255);
    String fnk = alphaChar.toRadixString(16).padLeft(4, '0');
    buffer.write(fnk);
  }
  String string = buffer.toString().toUpperCase().substring(10, 26);
  logger(string);
  return string;
}
