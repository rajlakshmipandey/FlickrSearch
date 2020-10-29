//
//  FlickerSearchAPI.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation

enum FlickerSearchAPI {
    case photos(searchText:String, pageNo:Int)
    case flickerImage(photo: Image, size: String)
}


extension FlickerSearchAPI: EndPointType {
    
    // For providing base url string based on API type
    private var baseURLString: String {
        switch self {
        case .photos:
            return ApiEndPoint.searchPhoto.urlString
        case .flickerImage:
            return ApiEndPoint.flickerImage.urlString
        }
    }
    
    
    // For providing a *URL* with the base url string
    var baseURL: URL {
        switch self {
        case .photos, .flickerImage:
            guard let url = URL(string: baseURLString) else {fatalError("Invalid Base URL.")}
            return url
        }
    }
    
    
    // To provide specific path for each API end point
    var path: String {
        switch self {
        case .photos:
            return ""
        case .flickerImage(let photo, let size):
            return  "\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_\(size).jpg"
        }
    }
    
    
    // To provide HTTP request method to be used in network request
    var httpMethod: HTTPMethod {
        return .get
    }
    
    
    // To provide request with specific query string parameters if required
    var task: HTTPTask {
        var params : HTTPParameters? = nil
        switch self {
        case .photos(let searchedText, let pageNo):
            params  = ["method": "flickr.photos.search","api_key": "3f1268436642e307ee1960f1a9ad9d70", "text": searchedText, "per_page": "20", "format":"json", "nojsoncallback": "1","page":pageNo]
        case .flickerImage:
            params = nil
        }
        return .request(urlParams: params)
    }
    
    
    // To provide request with cache  policy
    var cachingPolicy: URLRequest.CachePolicy {
        switch self {
        case .photos, .flickerImage:
            return .reloadIgnoringLocalCacheData
        }
    }
    
}
