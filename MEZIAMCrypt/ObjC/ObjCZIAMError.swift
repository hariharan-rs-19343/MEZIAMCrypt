//
//  ObjCZIAMError.swift
//  MEZIAMCrypt
//
//  Created by Hariharan R S on 23/04/25.
//

import Foundation
internal import ZIAMCryptKit

@objcMembers
public class ObjCZIAMError: NSObject, Error {
    @objc public var domain: String
    @objc public var code: ObjCZIAMCryptErrorStatus
    @objc public var errorInfo: [String: Any]?
    
    public init(
        domain: String,
        code: ObjCZIAMCryptErrorStatus,
        errorInfo: [String: Any]? = nil
    ) {
        self.domain = domain
        self.code = code
        self.errorInfo = errorInfo
    }
    
    convenience init(from error: ZIAMCryptError) {
        self.init(domain: error.domain, code: error.code.toObjC(), errorInfo: error.errorInfo)
    }
}

extension ZIAMCryptErrorStatus {
    
    func toObjC() -> ObjCZIAMCryptErrorStatus {
        switch self {
        case .keychainError:
            return ObjCZIAMCryptErrorStatus.keychainsError
        case .oldEncryptionKeyNotExpired:
            return ObjCZIAMCryptErrorStatus.oldEncryptionKeyNotExpired
        case .apiError:
            return ObjCZIAMCryptErrorStatus.apiError
        case .encryptionError:
            return ObjCZIAMCryptErrorStatus.encryptionError
        case .decryptionError:
            return ObjCZIAMCryptErrorStatus.decryptionError
        }
    }
            
}
