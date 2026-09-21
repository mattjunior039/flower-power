import re

with open("pubspec.yaml", "r") as f:
    content = f.read()

if "assets/extension_server/" not in content:
    content = content.replace("  assets:\n    - assets/", "  assets:\n    - assets/\n    - assets/extension_server/")

with open("pubspec.yaml", "w") as f:
    f.write(content)
