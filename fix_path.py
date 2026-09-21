with open("lib/modules/more/settings/browse/extension_server_screen.dart", "r") as f:
    content = f.read()

content = content.replace("assets/extension_server_fixed.jar", "assets/extension_server/MExtensionServer-v1.0.7-r1.jar")

with open("lib/modules/more/settings/browse/extension_server_screen.dart", "w") as f:
    f.write(content)
