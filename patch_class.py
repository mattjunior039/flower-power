with open("scratch/QuickJs.class", "rb") as f:
    data = bytearray(f.read())

import sys
# Find '10 07' followed by invokevirtual java/lang/String.substring (which is B6 ...)
# But easier: let's just find the exact sequence from javap.
# 379: aload         10 (19 0a)
# 381: bipush        7  (10 07)
# 383: invokevirtual #195 (B6 00 C3)
# Let's search for 19 0a 10 07 b6
idx = data.find(bytes.fromhex("190a1007b6"))
if idx != -1:
    print(f"Found at {idx}. Patching 10 07 to 10 0E")
    data[idx+2] = 0x0E
    with open("scratch/QuickJs.class", "wb") as f:
        f.write(data)
else:
    print("Not found! Let's search for 10 07.")
    for i in range(len(data)-1):
        if data[i] == 0x10 and data[i+1] == 0x07:
            print(f"Found 10 07 at {i}")
