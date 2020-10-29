//
//  FileHandler.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation


class FileHandler: NSObject {
    
    //MARK: Storing & Retriving Methods
    
    //Method to be used to store data on disc
    static func saveDataInFile<T:Codable>(data:T,fileName:String = "") -> Bool{
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(fileName)
            
            do {
                let data = try JSONEncoder().encode(data)
                try data.write(to: fileURL, options: .atomicWrite)
                return true
            }
            catch {
                return false
            }
        }
        return false
    }
    
    //Method to be used to retrive data from disc
    static func getDataFromFile<T: Codable>(fileName:String = "", to type: T.Type) -> T? {
        
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURL = dir.appendingPathComponent(fileName)
        guard let data = try? Data(contentsOf: fileURL, options: .mappedRead) else {return nil}
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {return nil}
        
        return decodedData
    }
    
}
