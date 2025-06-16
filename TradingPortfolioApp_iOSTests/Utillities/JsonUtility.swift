//
//  JsonUtility.swift
//  LevelShoesChalhoubTests

import Foundation

class JsonUtility {
    
    class func load<T:Codable>(fromJsonFile fileName: String, type: T.Type) -> T? {
    
        let bundle = Bundle(for: JsonUtility.self)
        
        guard let filePath = bundle.path(forResource: fileName, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
              let result = try? JSONDecoder().decode(T.self, from: data) else {
                  return nil
              }
        
        return result

    }
}
