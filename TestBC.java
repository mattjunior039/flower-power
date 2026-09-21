import java.security.Security;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import javax.crypto.Cipher;
import java.util.ArrayList;

public class TestBC {
    public static void main(String[] args) throws Exception {
        BouncyCastleProvider bc = new BouncyCastleProvider();
        ArrayList<Object> keysToRemove = new ArrayList<>();
        for (Object key : bc.keySet()) {
            String k = key.toString();
            // We want to KEEP AES, but ONLY symmetric cipher AES
            // Actually, let's just keep exactly AES, AES/CBC/ZEROBYTEPADDING
            if (!k.contains("AES") && !k.contains("ZeroBytePadding")) {
                keysToRemove.add(key);
            }
        }
        for (Object key : keysToRemove) {
            bc.remove(key);
        }
        Security.addProvider(bc);
        Cipher c = Cipher.getInstance("AES/CBC/ZEROBYTEPADDING");
        System.out.println("Success! Provider: " + c.getProvider().getName());
    }
}
