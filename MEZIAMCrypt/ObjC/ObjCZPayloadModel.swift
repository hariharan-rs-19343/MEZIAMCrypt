//
//  ObjCZPayloadModel.swift
//  ZIAMCryptKit
//
//  Created by Hariharan R S on 14/04/25.
//

import Foundation
internal import ZIAMCryptKit

@objcMembers
public class ObjCZPayloadModel: NSObject {
    
    /// Base64 encoded encrypted payload.
    // Dictionary with optional values needs special handling for Objective-C
    @objc public let content: [String: NSString]?
    
    /// Base64 encoded encrypted header.
    public let header: String
    
    public init(content: [String: NSString]?, header: String) {
        self.content = content
        self.header = header
    }
    
    convenience init(from payload: ZPayloadModel) {
        guard let _contents = payload.content else {
            self.init(content: nil, header: payload.header)
            return
        }
        
        let convertedContent: [String: NSString] = _contents.mapValues { $0! as NSString }
        self.init(content: convertedContent, header: payload.header)
    }
}
