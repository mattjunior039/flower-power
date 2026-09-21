#!/bin/bash
set -e
cd scratch/M-Extension-Server
./gradlew clean shadowJar
echo "Deploying..."
cp server/build/MExtensionServer-v1.0.7-r812.jar /Users/matthew/Documents/Mangayomi/extension_server/MExtensionServer-v1.0.7-r1.jar
echo "Restarting..."
pkill -f "java.*60430" || true
/Users/matthew/Documents/Mangayomi/extension_server/jre/jre/bin/java -jar /Users/matthew/Documents/Mangayomi/extension_server/MExtensionServer-v1.0.7-r1.jar 60430 > ../../java_server5.log 2>&1 &
echo "Done!"
