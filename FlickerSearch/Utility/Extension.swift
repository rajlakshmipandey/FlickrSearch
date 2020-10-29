//
//  Extension.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation

extension Data {
    
    //Decoding Json data
    func decode<T: Codable>(to type: T.Type, strategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let baseData = try decoder.decode(type, from: self)
            return baseData
        }
        catch let exception {
            print("exception is \(exception)")
            return nil
        }
    }
}
