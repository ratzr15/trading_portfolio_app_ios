//
//  NetworkError.swift
//  LevelShoesChalhoub

import Foundation

enum NetworkError: Error {
    case serverError(_ error: Error?)
    case invalidData
    case noData
}

enum URLRequestError: Error {
    case invalidRequest
}
