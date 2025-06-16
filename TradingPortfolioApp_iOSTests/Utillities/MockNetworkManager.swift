//
//  MockNetworkManager.swift
//  LevelShoesChalhoubTests

import Foundation
@testable import LevelShoesChalhoub

class MockNetworkManager: NetworkManager {
    
    private var mockFile: String
    
    init(withMockFile mockFile: String) {
        self.mockFile = mockFile
    }
    
    override func processRequest<T>(request: NetworkRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        let bundle = Bundle(for: MockNetworkManager.self)
        
        guard let filePath = bundle.path(forResource: mockFile, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
              let result = try? JSONDecoder().decode(T.self, from: data) else {
                  return
              }
        completion(.success(result))
    }
    
}
