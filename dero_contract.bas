Function Initialize(hash1 String, hash2 String, recipient String, asset String, timeLock Uint64) Uint64
1 IF EXISTS("signer") == 1 THEN GOTO 9
2 STORE("hash1", hash1)
3 STORE("hash2", hash2)
4 STORE("signer", ADDRESS_STRING(SIGNER()))
5 STORE("recipient", recipient)
6 STORE("timeLock", timeLock)
7 STORE("asset", asset)
8 STORE("amount", ASSET_VALUE(asset))
9 RETURN 0
End Function

Function Redeem(secret1 String, secret2 String) Uint64
1 IF SHA256(secret1) != LOAD("hash1") THEN GOTO 5
2 IF SHA256(secret2) != LOAD("hash2") THEN GOTO 5
3 IF SIGNER() != ADDRESS_RAW(LOAD("recipient")) THEN GOTO 5
4 SEND_ASSET_TO_ADDRESS(ADDRESS_RAW(LOAD("recipient")), LOAD("amount"), LOAD("asset"))
5 RETURN 0
End Function

Function Unlock() Uint64
1 IF SIGNER() != ADDRESS_RAW(LOAD("signer")) THEN GOTO 5
2 IF BLOCK_TIMESTAMP() <= LOAD("timeLock") THEN GOTO 5
3 SEND_ASSET_TO_ADDRESS(ADDRESS_RAW(LOAD("signer")), LOAD("amount"), LOAD("asset"))
4 RETURN 0
5 RETURN 1
End Function