//
//  HTTPURLParameterEncoder.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation

typealias HTTPParameters = [String:Any]

// Defines encoding error states
enum EncodingError: String,Error {
    case encodingFailed     = "HTTP parameters are nil"
    case encodeURLMissing   = "url to encode is nil"
}

// Defines interface for url query string parameters encoding
protocol HTTPParameterEncoder {
    
    // Encodes URLRequest with the passed url query string parameters
    static  func encode(urlRequest: inout URLRequest, httpParameters: HTTPParameters) throws
}

// Provides *URL* query string parameter encoder for the *URLRequest*
enum HTTPURLParameterEncoder: HTTPParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, httpParameters: HTTPParameters) throws{
        
        guard let urlToEcode = urlRequest.url else { throw EncodingError.encodeURLMissing}
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        guard var urlComponents = URLComponents(url: urlToEcode, resolvingAgainstBaseURL: false), !httpParameters.isEmpty else { return }
        
        urlComponents.queryItems = [URLQueryItem]()
        for (key,value) in httpParameters {
            let item = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(item)
        }
        urlRequest.url = urlComponents.url
    }
}
