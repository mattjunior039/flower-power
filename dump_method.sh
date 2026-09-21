unzip -q -p scratch/M-Extension-Server/server/build/MExtensionServer-v1.0.7-r812.jar app/cash/quickjs/QuickJs.class > scratch/QuickJs.class
javap -c scratch/QuickJs.class | grep -A 20 "translateTypeFromJson"
