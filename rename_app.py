import os
import glob

# Replace in .arb files
for arb_file in glob.glob('lib/l10n/*.arb'):
    with open(arb_file, 'r') as f:
        content = f.read()
    content = content.replace('Mangayomi', 'flower')
    content = content.replace('mangayomi', 'flower')
    with open(arb_file, 'w') as f:
        f.write(content)

# Replace in Info.plist
info_plist = 'macos/Runner/Info.plist'
with open(info_plist, 'r') as f:
    content = f.read()
content = content.replace('Mangayomi', 'flower')
content = content.replace('$(PRODUCT_NAME)', 'flower')
with open(info_plist, 'w') as f:
    f.write(content)

# Replace in pbxproj just in case
pbxproj = 'macos/Runner.xcodeproj/project.pbxproj'
with open(pbxproj, 'r') as f:
    content = f.read()
content = content.replace('PRODUCT_NAME = mangayomi;', 'PRODUCT_NAME = flower;')
with open(pbxproj, 'w') as f:
    f.write(content)

