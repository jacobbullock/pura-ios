//
//  API.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

class API {
    static let shared = API()
    let session = URLSession.shared

    func fetchWord(query: String) async throws -> Word? {
        guard !query.isEmpty else { throw APIError.emptyQuery }
        guard query.count > 2 else { throw APIError.tooShort(query) }
        
        let requestURL = URLBuilder(word: query.lowercased()).dictionaryRequestURL
        let result: [Word] = try await makeRequest(urlString: requestURL)
    
        var word = result.first
        word?.text = query
        word?.synonym = try await fetchSynonym(query: query)
        word?.giphy = try await fetchGiphy(query: query)

        return word
    }

    private func fetchSynonym(query: String) async throws -> Synonym? {
        let requestURL = URLBuilder(word: query.lowercased()).thesaurusRequestURL
        let result: [Synonym] = try await makeRequest(urlString: requestURL)
        
        return result.first
    }
    
    private func fetchGiphy(query: String) async throws -> Giphy? {
        let requestURL = URLBuilder(word: query.lowercased()).giphyRequestURL
        let result: Giphy = try await makeRequest(urlString: requestURL)
        
        return result
    }
    
    private func makeRequest<T: Codable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw APIError.badURL }
        
        let request = URLRequest(url: url)
        
        print("Fetching from: ", request.url?.absoluteString ?? "")
        
        let (data, _) = try await session.data(for: request)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
