//
//  FlickerPhotoDependency.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation

struct FlickerPhotoDependency: DependencyProtocol {
    
    //MARK: Properties
    
    var networkManager: ServiceManager
    
    //MARK: Initializer
    
    init() {
        networkManager = ServiceManager()
    }
    
    //MARK: Custom methods
    
    // Retrieve data from API
    func fetchData(for endPoint: FlickerSearchAPI, completion: @escaping ImageCompletionBlock) {
        networkManager.fetchData(endPoint, completion: { data, error in
            guard let data = data else {
                completion(nil,NetworkError.noResult)
                return
            }
            
            guard let photo =  data.decode(to: SearchResult.self) else {
                completion(nil, NetworkError.parsingError)
                return
            }
            completion(photo, nil)
            
        })
    }
}
