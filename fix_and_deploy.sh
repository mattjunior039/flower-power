#!/bin/bash
set -e

cd scratch/M-Extension-Server
./gradlew clean shadowJar

echo "Extracting QuickJs.class..."
unzip -q -j server/build/MExtensionServer-v1.0.7-r812.jar "app/cash/quickjs/QuickJs.class" -d .

echo "Patching..."
python3 -c '
with open("QuickJs.class", "rb") as f: data = bytearray(f.read())
idx = data.find(bytes.fromhex("190a1007b6"))
if idx != -1:
    data[idx+3] = 0x0E
    with open("QuickJs.class", "wb") as f: f.write(data)
    print("Patched successfully!")
else:
    print("Sequence not found!")
'

echo "Repacking..."
mkdir -p app/cash/quickjs
mv QuickJs.class app/cash/quickjs/
jar uf server/build/MExtensionServer-v1.0.7-r812.jar app/cash/quickjs/QuickJs.class

echo "Deploying..."
cp server/build/MExtensionServer-v1.0.7-r812.jar /Users/matthew/Documents/Mangayomi/extension_server/MExtensionServer-v1.0.7-r1.jar

echo "Restarting..."
pkill -f "java.*60430" || true
/Users/matthew/Documents/Mangayomi/extension_server/jre/jre/bin/java -jar /Users/matthew/Documents/Mangayomi/extension_server/MExtensionServer-v1.0.7-r1.jar 60430 > ../../java_server4.log 2>&1 &

echo "Done!"
