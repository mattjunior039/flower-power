with open("scratch/app/cash/quickjs/QuickJs.class", "rb") as f:
    data = bytearray(f.read())

idx = data.find(bytes.fromhex("190a0e07b6"))
if idx != -1:
    print(f"Found botched patch at {idx}. Fixing to 10 0E")
    data[idx+2] = 0x10 # restore bipush
    data[idx+3] = 0x0E # set argument to 14
    with open("scratch/app/cash/quickjs/QuickJs.class", "wb") as f:
        f.write(data)
else:
    print("Botched patch not found. Searching for original...")
    idx2 = data.find(bytes.fromhex("190a1007b6"))
    if idx2 != -1:
        print(f"Found original at {idx2}. Patching 10 07 to 10 0E")
        data[idx2+3] = 0x0E
        with open("scratch/app/cash/quickjs/QuickJs.class", "wb") as f:
            f.write(data)
