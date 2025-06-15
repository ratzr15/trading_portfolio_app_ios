//
//  URLSessionBuildable.swift
//  LevelShoesChalhoub

import Foundation

protocol URLSessionBuildable {
    func fetchDataTask(with: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLSessionBuildable {
    
    func fetchDataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let task = dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
}
