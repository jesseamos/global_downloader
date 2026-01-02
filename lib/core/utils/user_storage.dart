import 'dart:convert';

import 'package:crypto_dart/crypto_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorage {
  var storage = const FlutterSecureStorage();
  // final String key = 'ThisIsASecretKey';
  final String key =
      dotenv.env['EN_KEY_AES'] ?? ""; // Your secret key for AES encryption

  Future<void> setPassword(String password) async {
    // Convert the key to bytes if needed
    final keyBytes = utf8.encode(key);

    // Encrypt the password
    final encryptedBytes = CryptoDart.AES.encrypt(password, keyBytes);

    // Encode encrypted bytes to a base64 string before storing
    final base64Password = base64.encode(encryptedBytes.cipherText);

    // log(base64Password,
    //     name: "Encrypted Password"); // Use cipherText for base64
    await storage.write(key: 'password', value: base64Password);
  }

  Future<String?> getPassword() async {
    final encryptedPassword = await storage.read(key: 'password');
    if (encryptedPassword == null) return null;

    // Decode the base64 string to get the original encrypted bytes
    final encryptedBytes = base64.decode(encryptedPassword);

    // Decrypt the bytes (ensure the key is in the correct format)
    final decryptedBytes = CryptoDart.AES.decrypt(
      encryptedBytes,
      utf8.encode(key),
    ); // Use key as bytes

    // Convert decrypted bytes back to a String

    // log(utf8.decode(decryptedBytes), name: "Decrypted Password");
    return utf8.decode(decryptedBytes);
  }

  Future<void> setPin(String pin) async {
    // Convert the key to bytes if needed
    final keyBytes = utf8.encode(key);

    // Encrypt the password
    final encryptedBytes = CryptoDart.AES.encrypt(pin, keyBytes);

    // Encode encrypted bytes to a base64 string before storing
    final base64Pin = base64.encode(encryptedBytes.cipherText);

    // log(base64Password,
    //     name: "Encrypted Password"); // Use cipherText for base64
    await storage.write(key: 'pin', value: base64Pin);
  }

  Future<String?> getPin() async {
    final encryptedPin = await storage.read(key: 'pin');
    if (encryptedPin == null) return null;

    // Decode the base64 string to get the original encrypted bytes
    final encryptedBytes = base64.decode(encryptedPin);

    // Decrypt the bytes (ensure the key is in the correct format)
    final decryptedBytes = CryptoDart.AES.decrypt(
      encryptedBytes,
      utf8.encode(key),
    ); // Use key as bytes

    // Convert decrypted bytes back to a String

    // log(utf8.decode(decryptedBytes), name: "Decrypted Password");
    return utf8.decode(decryptedBytes);
  }

  setToken(accessToken) async {
    await storage.write(key: 'token', value: accessToken);
  }

  setUserToken(userToken) async {
    await storage.write(key: 'userToken', value: userToken);
  }

  setLoginType(loginType) async {
    await storage.write(key: 'loginType', value: loginType);
  }

  setBiometricToken(biometricToken) async {
    await storage.write(key: 'biometricToken', value: biometricToken);
  }

  // setUser(User user) async {
  //   String userJson = json.encode(user.toJson());
  //   await storage.write(key: 'userData', value: userJson);
  // }

  setNotificationToken(notificationToken) async {
    await storage.write(key: 'notification_token', value: notificationToken);
  }

  removeStorage() async {
    await storage.deleteAll();
  }

  Future get sessionData async {
    var session = await storage.readAll();
    return session;
  }

  Future get location async {
    var location = await storage.read(key: 'location');
    debugPrint(location);
    return location;
  }

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "token");
    if (jwt == null) return '';
    return jwt;
  }

  Future<String> get userToken async {
    var jwt = await storage.read(key: "userToken");
    if (jwt == null) return 'empty';
    return jwt;
  }

  Future<String> get loginType async {
    var jwt = await storage.read(key: "loginType");
    if (jwt == null) return 'empty';
    return jwt;
  }

  Future<String> get biometricToken async {
    var token = await storage.read(key: "biometricToken");
    if (token == null) return '';
    return token;
  }

  // Future<User?> get userData async {
  //   var data = await storage.read(key: "userData");
  //   if (data == null) return null;

  //   return User.fromJson(json.decode(data));
  // }

  Future<String> get notificationToken async {
    var fcmToken = await storage.read(key: "notification_token");

    if (fcmToken == null) return '';

    return fcmToken;
  }
}
