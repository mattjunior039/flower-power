import 'package:pointycastle/pointycastle.dart';
void main() {
  try {
    PaddedBlockCipher('AES/CBC/ZEROBYTEPADDING');
  } catch (e) {
    print(e);
  }
}
