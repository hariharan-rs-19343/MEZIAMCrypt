//
//  ObjCZIAMDecryptResult.swift
//  MEZIAMCrypt
//
//  Created by Hariharan R S on 23/04/25.
//

import Foundation
internal import ZIAMCryptKit

@objc
public class ObjCZIAMDecryptResult: NSObject {
    @objc public var data: Data?
    @objc public var error: ObjCZIAMError?
    
    @objc
    public init(data: Data? = nil, error: ObjCZIAMError? = nil) {
        self.data = data
        self.error = error
    }
    
    convenience init(from result: ZIAMDecrpytResult?) {
        guard let result else {
            self.init()
            return
        }
        
        switch result {
        case .success(let data):
            self.init(data: data, error: nil)
        case .failure(let error):
            self.init(data: nil, error: ObjCZIAMError(from: error))
        }
    }
}
