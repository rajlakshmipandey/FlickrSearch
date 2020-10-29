//
//  NetworkServiceHelper.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
    // MARK: - Cases
    case parsingError
    case invalidPath
    case parseError
    case requestError
    case internetError
    case failed
    case noResult
    
    var errorDescription:String {
        switch self {
        case .noResult:
            return "No content found"
        case .parsingError, .invalidPath, .parseError, .requestError, .failed:
            return "Please try again after some time."
        case .internetError:
            return "It seems there is no internet on your device."
        }
    }
}




// For Setting network envoirenment of the app
enum NetworkEnvironment {
    case staging
    case production
    case development
}


// Defines network response status and provides error strings for network request error
enum NetworkResponse: String {
    case success
    case authenticationError    = "Authentication Error"
    case badRequest             = "Bad Request"
    case failed                 = "Network request Failed"
    case noData                 = "No Data Found"
    case unableToDecode         = "Decoding Error"
    case noInternet             = "No Internet Connectivity."
}


// Completion handler to return data and error
typealias NetworkCompletionBlock = (_ data: Data?,_ error: Error?)-> ()


enum ApiEndPoint {
    case searchPhoto
    case flickerImage
    
    // url endpoint for Flicker apis
    var urlString: String {
        switch self {
        case .searchPhoto:
            return "https://api.flickr.com/services/rest/"
        case .flickerImage:
            return "https://farm"
        }
    }
}


// Defines Endpoint to provide required properties for any API endpoint
protocol EndPointType {
    var baseURL         : URL { get }
    var path            : String { get }
    var httpMethod      : HTTPMethod { get }
    var task            : HTTPTask { get }
    var cachingPolicy   : URLRequest.CachePolicy { get }
}


// Defines different HTTP request methods
enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}


// Defines request with *HTTPParameters* for  *URLRequest* query parameters
enum HTTPTask {
    case request(urlParams: HTTPParameters?)
}

