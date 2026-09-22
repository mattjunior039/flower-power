with open("lib/modules/more/settings/browse/extension_server_screen.dart", "r") as f:
    content = f.read()

# Add import
if "import 'package:flutter/services.dart';" not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:flutter/services.dart';")

old_code = """    await _extractArchive(bundleZip, installDir);
    final resolvedPaths = await _resolvePathsInDirectory(installDir);"""

new_code = """    await _extractArchive(bundleZip, installDir);

    // --- ANTIGRAVITY FIX INJECTION ---
    // Delete the official (broken) JAR
    final officialJarPath = await findExtensionServerJar(installDir);
    if (officialJarPath != null) {
      await File(officialJarPath).delete();
    }
    // Copy our patched JAR from assets
    final fixedJarPath = path.join(installDir.path, 'MExtensionServer-v1.0.7-r1.jar');
    final byteData = await rootBundle.load('assets/extension_server/MExtensionServer-v1.0.7-r1.jar');
    final buffer = byteData.buffer;
    await File(fixedJarPath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    // ---------------------------------

    final resolvedPaths = await _resolvePathsInDirectory(installDir);"""

content = content.replace(old_code, new_code)

with open("lib/modules/more/settings/browse/extension_server_screen.dart", "w") as f:
    f.write(content)
