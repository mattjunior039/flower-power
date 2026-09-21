import 'package:encrypt/encrypt.dart';
void main() {
  try {
    final encrypter = Encrypter(
      AES(Key.fromLength(32), mode: AESMode.cbc, padding: 'ZEROBYTEPADDING'),
    );
    encrypter.decrypt64('aaaa', iv: IV.fromLength(16));
  } catch (e) {
    print(e);
  }
}
