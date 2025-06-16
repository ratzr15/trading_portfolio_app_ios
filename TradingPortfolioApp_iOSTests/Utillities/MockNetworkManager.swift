//
//  MockNetworkManager.swift
//  TradingPortfolioAppTests

import Foundation
import UIKit
@testable import TradingPortfolioApp_iOS

class MockNetworkManager: NetworkManager {
   
    var shouldSucceed: Bool
    var mockResponse: PortfolioResponse?
    var mockError: Error?
    var invokedRequest: NetworkRequest?
    var invokedType: Any.Type?

    init(shouldSucceed: Bool = true, mockResponse: PortfolioResponse? = nil, mockError: Error? = nil) {
        self.shouldSucceed = shouldSucceed
        self.mockResponse = mockResponse
        self.mockError = mockError
    }
    
    override func processRequest<T: Decodable>(request: NetworkRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        invokedRequest = request
        invokedType = type

        if shouldSucceed {
            if let response = mockResponse as? T {
                completion(.success(response))
            } else if T.self == PortfolioResponse.self {
                completion(.success(PortfolioResponse.dummy as! T))
            } else {
                completion(.failure(NSError(domain: "MockError", code: 500, userInfo: [NSLocalizedDescriptionKey: "No mock response provided for type \(T.self)"])))
            }
        } else {
            let errorToReturn = mockError ?? NSError(domain: "MockError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Mock network error"])
            completion(.failure(errorToReturn))
        }
    }
}
