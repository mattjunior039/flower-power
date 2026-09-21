import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
// 1. Import your generated Rust bridge
import 'package:flower_power/src/rust/api/crypto.dart';

class CryptoAES {
  static String encryptAESCryptoJS(String plainText, String passphrase) {
    try {
      final salt = genRandomWithNonZero(8);
      var keyndIV = deriveKeyAndIV(passphrase.trim(), salt);
      final key = encrypt.Key(keyndIV.$1);
      final iv = encrypt.IV(keyndIV.$2);

      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"),
      );
      final encrypted = encrypter.encrypt(plainText.trim(), iv: iv);
      Uint8List encryptedBytesWithSalt = Uint8List.fromList(
        createUint8ListFromString("Salted__") + salt + encrypted.bytes,
      );
      return base64.encode(encryptedBytesWithSalt);
    } catch (error) {
      rethrow;
    }
  }

  // 2. CryptoJS Decryption (Aggressive Interceptor)
  static Future<String> decryptAESCryptoJS(
    String encrypted, 
    String passphrase, 
    [String padding = "PKCS7"]
  ) async {
    try {
      Uint8List encryptedBytesWithSalt = base64.decode(encrypted.trim());

      Uint8List encryptedBytes = encryptedBytesWithSalt.sublist(
        16,
        encryptedBytesWithSalt.length,
      );
      final salt = encryptedBytesWithSalt.sublist(8, 16);
      var keyndIV = deriveKeyAndIV(passphrase.trim(), salt);
      final key = encrypt.Key(keyndIV.$1);
      final iv = encrypt.IV(keyndIV.$2);

      // 3. Route to your custom Rust logic regardless of case formatting
      String padUpper = padding.toUpperCase();
      if (padUpper.contains("ZEROBYTEPADDING") || padUpper.contains("ZEROPADDING")) {
        final decryptedBytes = await decryptAesCbcZeroPadding(
          data: encryptedBytes,
          key: key.bytes,
          iv: iv.bytes,
        );
        return utf8.decode(decryptedBytes);
      }

      // 4. Default PKCS7 logic using standard Dart library
      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: padding),
      );
      final decrypted = encrypter.decrypt64(
        base64.encode(encryptedBytes),
        iv: iv,
      );
      return decrypted;
    } catch (error) {
      rethrow;
    }
  }

  // 5. Standard AES Decryption (Required for Mangago page lists)
  static Future<String> decryptAES(
    String encrypted,
    String keyString,
    String ivString,
    [String padding = "PKCS7"]
  ) async {
    try {
      final key = encrypt.Key.fromUtf8(keyString);
      final iv = encrypt.IV.fromUtf8(ivString);
      final encryptedBytes = base64.decode(encrypted.trim());

      String padUpper = padding.toUpperCase();
      if (padUpper.contains("ZEROBYTEPADDING") || padUpper.contains("ZEROPADDING")) {
        final decryptedBytes = await decryptAesCbcZeroPadding(
          data: encryptedBytes,
          key: key.bytes,
          iv: iv.bytes,
        );
        return utf8.decode(decryptedBytes);
      }

      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: padding),
      );
      return encrypter.decrypt64(encrypted.trim(), iv: iv);
    } catch (error) {
      rethrow;
    }
  }

  static (Uint8List, Uint8List) deriveKeyAndIV(
    String passphrase,
    Uint8List salt,
  ) {
    var password = createUint8ListFromString(passphrase);
    Uint8List concatenatedHashes = Uint8List(0);
    Uint8List currentHash = Uint8List(0);
    bool enoughBytesForKey = false;
    Uint8List preHash = Uint8List(0);

    while (!enoughBytesForKey) {
      if (currentHash.isNotEmpty) {
        preHash = Uint8List.fromList(currentHash + password + salt);
      } else {
        preHash = Uint8List.fromList(password + salt);
      }

      currentHash = md5.convert(preHash).bytes as Uint8List;
      concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
      if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
    }

    var keyBtyes = concatenatedHashes.sublist(0, 32);
    var ivBtyes = concatenatedHashes.sublist(32, 48);
    return (keyBtyes, ivBtyes);
  }

  static Uint8List createUint8ListFromString(String s) {
    var ret = Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }

  static Uint8List genRandomWithNonZero(int seedLength) {
    final random = Random.secure();
    const int randomMax = 245;
    final Uint8List uint8list = Uint8List(seedLength);
    for (int i = 0; i < seedLength; i++) {
      uint8list[i] = random.nextInt(randomMax) + 1;
    }
    return uint8list;
  }
}