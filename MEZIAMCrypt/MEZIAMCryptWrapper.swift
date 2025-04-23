//
//  MEZIAMCrypt.swift
//  MEZIAMCrypt
//
//  Created by Hariharan R S on 23/04/25.
//

import Foundation
internal import ZIAMCryptKit

@objc
public class MEZIAMCryptWrapper: NSObject {
    
    // MARK: - Singleton
    @objc public static let shared = MEZIAMCryptWrapper()
    
    private var ziamCrypt: ZIAMCrypt!
    
    private override init() {
        super.init()
    }
    
    @objc public func createInstance(publickeyTag: String, privatekeyTag: String, serverPublickeyTag: String) {
        self.ziamCrypt = ZIAMCrypt(publickeyTag: publickeyTag, privatekeyTag: privatekeyTag, serverPublickeyTag: serverPublickeyTag)
    }
    
    @objc public func checkExpiryAndGetEncryptedPayload(
        dict: [String: Data],
        baseURL: String,
        scope: String = "org",
        headers: [String: String]? = nil,
        completion: @escaping (ObjCZIAMCryptAPIResponse?, ObjCZIAMEncryptResult?) -> Void
    ) {
        guard let ziamCrypt = ziamCrypt else {
            fatalError("ZIAMCrypt instance is not initialized. Call createInstance() first.")
        }
        
        ziamCrypt.checkExpiryAndGetEncryptedPayload(dict, baseURL: baseURL, scope: scope, headers: headers) { handshakeResponse, encryptedPayload in
            let objCZIAMCryptAPIResponse: ObjCZIAMCryptAPIResponse? = ObjCZIAMCryptAPIResponse(from: handshakeResponse)
            let objCZIAMEncryptResult: ObjCZIAMEncryptResult? = ObjCZIAMEncryptResult(from: encryptedPayload)
            completion(objCZIAMCryptAPIResponse, objCZIAMEncryptResult)
        }
    }
    
    @objc public func getDecryptedPayload(headerValue: String, payload: Data) -> ObjCZIAMDecryptResult? {
        guard let ziamCrypt = ziamCrypt else {
            fatalError("ZIAMCrypt instance is not initialized. Call createInstance() first.")
        }
        
        let decryptResult = ziamCrypt.getDecryptedPayload(headerValue, payload: payload)
        return ObjCZIAMDecryptResult(from: decryptResult)
    }
    
    @objc public func deleteKeyPair() {
        guard let ziamCrypt = ziamCrypt else {
            fatalError("ZIAMCrypt instance is not initialized. Call createInstance() first.")
        }
        
        ziamCrypt.deleteStoredKeyPair()
    }

}
