import re

with open("lib/modules/more/settings/browse/extension_server_screen.dart", "r") as f:
    content = f.read()

# We need to add an import for rootBundle
if "import 'package:flutter/services.dart'" not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:flutter/services.dart';")

# Find _installDownloadedBundle
old_install = """  Future<void> _installDownloadedBundle(
      File bundleZip, Directory installDir, AppLocalizations l10n) async {
    try {
      await extractZip(bundleZip.path, installDir.path);
    } catch (e) {
      throw Exception(l10n.failed_to_extract_bundle);
    }

    final jarPath = await findExtensionServerJar(installDir);
    if (jarPath == null) {
      throw Exception(l10n.downloaded_bundle_missing_expected_files);
    }
  }"""

new_install = """  Future<void> _installDownloadedBundle(
      File bundleZip, Directory installDir, AppLocalizations l10n) async {
    try {
      await extractZip(bundleZip.path, installDir.path);
    } catch (e) {
      throw Exception(l10n.failed_to_extract_bundle);
    }

    // --- ANTIGRAVITY FIX INJECTION ---
    // Delete the official (broken) JAR
    final officialJarPath = await findExtensionServerJar(installDir);
    if (officialJarPath != null) {
      await File(officialJarPath).delete();
    }
    // Copy our patched JAR from assets
    final fixedJarPath = path.join(installDir.path, 'MExtensionServer-v1.0.7-r1.jar');
    final byteData = await rootBundle.load('assets/extension_server_fixed.jar');
    final buffer = byteData.buffer;
    await File(fixedJarPath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    // ---------------------------------

    final jarPath = await findExtensionServerJar(installDir);
    if (jarPath == null) {
      throw Exception(l10n.downloaded_bundle_missing_expected_files);
    }
  }"""

content = content.replace(old_install, new_install)

with open("lib/modules/more/settings/browse/extension_server_screen.dart", "w") as f:
    f.write(content)
