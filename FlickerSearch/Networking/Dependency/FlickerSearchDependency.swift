//
//  FlickerSearchDependency.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation

import Foundation

// Completion block for network service
typealias ImageCompletionBlock = (_ photos: SearchResult?,_ error: NetworkError?)-> ()


// Protocol to be used to fetch photo data
protocol DependencyProtocol {
    func fetchData(for endPoint: FlickerSearchAPI, completion: @escaping ImageCompletionBlock)
}


struct FlickerSearchDependency {
    private init() {}
    
    // Method to be used to return FlickerPhotoService to receive photos from api
    static func getFlickerService() -> DependencyProtocol {
        return FlickerPhotoDependency()
    }
    
}
