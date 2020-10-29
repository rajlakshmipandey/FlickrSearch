//
//  ImageDataModel.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/24/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//


// MARK: Image model
struct Image: Codable {
    var farm : Int
    var server : String
    var secret : String
    var id: String
}

// MARK: Image-list Model
struct Images: Codable {
    var page: Int
    var pages: Int
    var perpage: Int
    var total:String
    var photo:[Image]
}


// MARK: Search result model
struct SearchResult: Codable {
    var stat: String
    var photos: Images
}
