import zipfile
import io

jar_path = "scratch/M-Extension-Server/server/build/MExtensionServer-v1.0.7-r812.jar"

with open(jar_path, "rb") as f:
    jar_data = f.read()

# Instead of extracting, let's just do a binary replace on the entire JAR!
# Is the class compressed in the jar? Yes, probably.
# So we must extract it.
