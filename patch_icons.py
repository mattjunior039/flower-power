import re

with open("pubspec.yaml", "r") as f:
    content = f.read()

content = content.replace('image_path: "assets/app_icons/icon-red.png"', 'image_path: "assets/app_icons/flower.jpg"')

with open("pubspec.yaml", "w") as f:
    f.write(content)
