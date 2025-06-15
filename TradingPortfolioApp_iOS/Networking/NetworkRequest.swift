//
//  NetworkRequest.swift
//  LevelShoesChalhoub

import Foundation

protocol NetworkRequest {
    var baseURL: String { get }
    var requestPath: String { get }
    var urlRequest: URLRequest? { get }
}

extension NetworkRequest {
    
    var baseURL: String {
        return NetworkConstants.baseUrl
    }
            
    var urlRequest: URLRequest? {
        
        var urlString  = baseURL
        
        if !requestPath.isEmpty {
            urlString  = baseURL +  "/" + requestPath
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}

