//
//  ZIAMCryptWrapper.swift
//  MEZIAMCrypt
//
//  Created by Hariharan R S on 24/04/25.
//

import Foundation
internal import ZIAMCryptKit

@objcMembers
public class ZIAMCryptWrapper: NSObject {
    
    // MARK: - Singleton
    @objc public static let shared = ZIAMCryptWrapper()
    
    private var ziamCrypt: ZIAMCrypt!
    
    private override init() {
        super.init()
    }
    
    @objc
    public func createInstance(publickeyTag: String, privatekeyTag: String, serverPublickeyTag: String) {
        self.ziamCrypt = ZIAMCrypt(publickeyTag: publickeyTag, privatekeyTag: privatekeyTag, serverPublickeyTag: serverPublickeyTag)
    }
    
    @objc public func checkExpiryAndGetEncryptedPayload(
        dict: [String: Data],
        baseURL: String,
        scope: String = "org",
        headers: [String: String]? = nil,
        completion: @escaping (ObjCZIAMCryptAPIResponse?, ObjCZIAMEncryptResult?) -> Void
    ) {
        ziamCrypt.checkExpiryAndGetEncryptedPayload(dict, baseURL: baseURL, scope: scope, headers: headers) { handshakeResponse, encryptedPayload in
            let objCZIAMCryptAPIResponse: ObjCZIAMCryptAPIResponse? = ObjCZIAMCryptAPIResponse(from: handshakeResponse)
            let objCZIAMEncryptResult: ObjCZIAMEncryptResult? = ObjCZIAMEncryptResult(from: encryptedPayload)
            completion(objCZIAMCryptAPIResponse, objCZIAMEncryptResult)
        }
        
    }
}
