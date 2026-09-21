import 'package:encrypt/encrypt.dart';
void main() {
  try {
    AES(Key.fromLength(32), mode: AESMode.cbc, padding: 'AES/CBC/ZEROBYTEPADDING').cipher;
  } catch (e) {
    print(e);
  }
}
