import java.security.Security;
import org.bouncycastle.jce.provider.BouncyCastleProvider;

public class TestProvider {
    public static void main(String[] args) {
        BouncyCastleProvider bc = new BouncyCastleProvider();
        for (Object key : bc.keySet()) {
            if (key.toString().contains("ZEROBYTEPADDING")) {
                System.out.println(key + " -> " + bc.get(key));
            }
        }
    }
}
