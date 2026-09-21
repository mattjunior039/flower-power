use aes::cipher::{block_padding::NoPadding, BlockDecryptMut, KeyIvInit};

// Create an alias for AES-256 CBC Decryptor
type Aes256CbcDec = cbc::Decryptor<aes::Aes256>;

pub fn decrypt_aes_cbc_zero_padding(data: Vec<u8>, key: Vec<u8>, iv: Vec<u8>) -> Vec<u8> {
    let mut buffer = data;
    
    // Initialize the decryptor using standard AES-CBC
    if let Ok(decryptor) = Aes256CbcDec::new_from_slices(&key, &iv) {
        // Decrypt the block without expecting standard padding
        if let Ok(decrypted) = decryptor.decrypt_padded_mut::<NoPadding>(&mut buffer) {
            
            // Manually trim the ZeroBytePadding from the end
            let mut len = decrypted.len();
            while len > 0 && decrypted[len - 1] == 0 {
                len -= 1;
            }
            return decrypted[..len].to_vec();
        }
    }
    vec![]
}