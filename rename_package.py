import os
import glob

def replace_in_file(filepath, old_str, new_str):
    with open(filepath, 'r') as f:
        content = f.read()
    if old_str in content:
        content = content.replace(old_str, new_str)
        with open(filepath, 'w') as f:
            f.write(content)

# 1. Update pubspec.yaml
replace_in_file('pubspec.yaml', 'name: mangayomi', 'name: flower_power')

# 2. Update all dart files
for root, dirs, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            replace_in_file(os.path.join(root, file), "package:mangayomi/", "package:flower_power/")

for root, dirs, files in os.walk('test'):
    for file in files:
        if file.endswith('.dart'):
            replace_in_file(os.path.join(root, file), "package:mangayomi/", "package:flower_power/")

