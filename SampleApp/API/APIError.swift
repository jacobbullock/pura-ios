//
//  APIError.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


enum APIError: Error {
    case badURL
    case custom(String)
    case noData
    case emptyQuery
    case tooShort(String)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL: return "The request url is not formed properly, The programmers will now have to submit a new build and wait for apple approve it. It's a very daunting process"
        case .custom(let str): return str
        case .noData: return "There was no data for this word"
        case .emptyQuery: return "Please enter a word to search"
        case .tooShort: return "Please enter a word that is at least 3 characters. We assume that you already know all the definitions of all two letter words."
        }
    }
}
