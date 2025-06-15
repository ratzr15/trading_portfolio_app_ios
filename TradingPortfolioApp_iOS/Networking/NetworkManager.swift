//
//  NetworkManager.swift
//  LevelShoesChalhoub

import Foundation
protocol NetworkContract {
    func processRequest<T: Codable>(request: NetworkRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkManager: NetworkContract {
    
    let session: URLSessionBuildable
    
    init(session: URLSessionBuildable = URLSession.shared) {
        self.session = session
    }
    
    func processRequest<T: Codable>(request: NetworkRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let request = request.urlRequest else {
            completion(.failure(URLRequestError.invalidRequest))
            return
        }
        
        session.fetchDataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(Result.failure(NetworkError.invalidData))
                return
            }
            
            if let error = error {
                completion(Result.failure(NetworkError.serverError(error)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(response))
            }
            catch(let error) {
                print(error)
                completion(Result.failure(NetworkError.invalidData))
            }
        }
    }
}

