//
//  ObjCZIAMCryptErrorStatus.swift
//  MEZIAMCrypt
//
//  Created by Hariharan R S on 23/04/25.
//

import Foundation

@objc public enum ObjCZIAMCryptErrorStatus: Int {
    case keychainsError = -1000
    case oldEncryptionKeyNotExpired = -1001
    case apiError = -1002
    case encryptionError = -1003
    case decryptionError = -1004
}
