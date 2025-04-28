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
        let convertedDict: [String: Data] = dict.mapValues { $0.data(using: .utf8) ?? Data() }
        
        ziamCrypt.checkExpiryAndGetEncryptedPayload(convertedDict, baseURL: baseURL, scope: scope, headers: headers) { handshakeResponse, encryptedPayload in
            let objCZIAMCryptAPIResponse: ObjCZIAMCryptAPIResponse? = ObjCZIAMCryptAPIResponse(from: handshakeResponse)
            let objCZIAMEncryptResult: ObjCZIAMEncryptResult? = ObjCZIAMEncryptResult(from: encryptedPayload)
            completion(objCZIAMCryptAPIResponse, objCZIAMEncryptResult)
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
