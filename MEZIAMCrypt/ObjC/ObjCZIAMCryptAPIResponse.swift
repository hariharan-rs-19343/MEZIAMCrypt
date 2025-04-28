//
//  ObjCZIAMCryptAPIResponse.swift
//  MEZIAMCrypt
//
//  Created by Hariharan R S on 23/04/25.
//

import Foundation
internal import ZIAMCryptKit

@objcMembers
public class ObjCZIAMCryptAPIResponse: NSObject {
    @objc public var json: [String: Any]?
    public var response: URLResponse
    public var error: Error?
    
    init(json: [String: Any]?, response: URLResponse, error: Error?) {
        self.json = json
        self.response = response
        self.error = error
    }
    
    convenience init(from result: ZIAMCryptAPIResponse?) {
        guard let result else {
            self.init(json: nil, response: URLResponse(), error: NSError(domain: "Response could not be parsed", code: -1000))
            return
        }
        
        switch result {
        case .success(let value):
            let convertedJson: [String: Any]? = value.json.mapValues { $0 }
            self.init(json: convertedJson, response: value.response, error: nil)
        case .failure(let error):
            self.init(json: nil, response: URLResponse(), error: error)
        }
    }
}
