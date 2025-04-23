//
//  ObjCZIAMEncryptResult.swift
//  MEZIAMCrypt
//
//  Created by Hariharan R S on 23/04/25.
//

import Foundation
internal import ZIAMCryptKit

@objcMembers
public class ObjCZIAMEncryptResult: NSObject {
    public var payload: ObjCZPayloadModel?
    public var error: ObjCZIAMError?
    
    public init(payload: ObjCZPayloadModel?, error: ObjCZIAMError?) {
        self.payload = payload
        self.error = error
    }
     
    convenience init(from result: ZIAMEncrpytResult?) {
        guard let result = result else {
            self.init(payload: nil, error: ObjCZIAMError(domain: ZIAMCryptConstants.k_errorDomain, code: .decryptionError))
            return
        }
        
        switch result {
        case .success(let zpayload):
            self.init(payload: .init(from: zpayload), error: nil)
        case .failure(let error):
            self.init(payload: nil, error: ObjCZIAMError(from: error))
            
        }
    }
}
