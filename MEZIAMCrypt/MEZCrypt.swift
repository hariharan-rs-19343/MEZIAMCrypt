//
//  MEZCrypt.swift
//  MEZIAMCrypt
//
//  Created by Hariharan R S on 24/04/25.
//

import Foundation
internal import ZIAMCryptKit

@objcMembers
public class MEZCrypt: NSObject {
    
    private var ziamCrypt: ZIAMCrypt
    
    @objc public init(publicKeyTag: String, privateKeyTag: String, serverPublickeyTag: String) {
        self.ziamCrypt = ZIAMCrypt(publickeyTag: publicKeyTag, privatekeyTag: privateKeyTag, serverPublickeyTag: serverPublickeyTag)
    }
    
    @objc public func checkExpiryAndGetEncryptedPayload(
        dict: [String: String],
        baseURL: String,
        scope: String = "org",
        headers: [String: String]? = nil,
        completion: @escaping (ObjCZIAMCryptAPIResponse?, ObjCZIAMEncryptResult?) -> Void
    ) {
        debugPrint("DEBUG: MEZIAMCRYPT: Checking expiry and getting encrypted payload...")
        let convertedDict: [String: Data] = dict.mapValues { $0.data(using: .utf8) ?? Data() }
        print("convertedDict \(convertedDict)")
        debugPrint("DEBUG: MEZIAMCRYPT: Converted Dictionary: \(convertedDict)")
        
        ziamCrypt.checkExpiryAndGetEncryptedPayload(convertedDict, baseURL: baseURL, scope: scope, headers: headers) { handshakeResponse, encryptedPayload in
            let objCZIAMCryptAPIResponse: ObjCZIAMCryptAPIResponse? = ObjCZIAMCryptAPIResponse(from: handshakeResponse)
            let objCZIAMEncryptResult: ObjCZIAMEncryptResult? = ObjCZIAMEncryptResult(from: encryptedPayload)
            completion(objCZIAMCryptAPIResponse, objCZIAMEncryptResult)
        }
    }
    
    @objc public func checkExpiryAndGetEncryptedPayload(
        baseURL: String,
        scope: String = "org"
    ) {
        debugPrint("DEBUG: MEZIAMCRYPT: Checking expiry and getting encrypted payload...")
        
        let headers: [String: String] = [
            "Authorization": "Zoho-oauthtoken 1002.8bcecdb86625f4322d9c6752da06cb83.b64da947dc980c054798b8d8d4901df4",
            "Accept": "application/json, application/vnd.manageengine.sdpod.v3+json",
            "Content-Type": "application/x-www-form-urlencoded",
            "x-sdpod-appid": "54195000"
        ]
        
        ziamCrypt.checkExpiryAndGetEncryptedPayload([:], baseURL: baseURL, scope: scope, headers: headers) { handshakeResponse, encryptedPayload in
            let objCZIAMCryptAPIResponse: ObjCZIAMCryptAPIResponse? = ObjCZIAMCryptAPIResponse(from: handshakeResponse)
            let objCZIAMEncryptResult: ObjCZIAMEncryptResult? = ObjCZIAMEncryptResult(from: encryptedPayload)
            print(objCZIAMCryptAPIResponse ?? "Handshake response is nil")
            print(objCZIAMEncryptResult ?? "Encrypted payload is nil")
        }
    }
    
    @objc public func getDecryptedPayload(headerValue: String, payload: Data) -> ObjCZIAMDecryptResult? {
        let decryptResult = ziamCrypt.getDecryptedPayload(headerValue, payload: payload)
        return ObjCZIAMDecryptResult(from: decryptResult)
    }
    
    @objc public func deleteKeyPair() {
        ziamCrypt.deleteStoredKeyPair()
    }
}
