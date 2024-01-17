//
//  URLBuilder.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

extension URLBuilder {
    enum Request {
        case dictionary
        case thesaurus
        case giphy
        
        var url: String {
            switch self {
            case .dictionary: return "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
            case .thesaurus: return "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/"
            case .giphy: return "https://api.giphy.com/v1/gifs/search"
            }
        }
    }
}

struct URLBuilder {
    var word: String

    var dictionaryRequestURL: String {
        Request.dictionary.url + word + "?key=" + Tokens.apiKeyDict
    }
    
    var thesaurusRequestURL: String {
        Request.thesaurus.url + word + "?key=" + Tokens.apiKeyThes
    }
    
    var giphyRequestURL: String {
        Request.giphy.url + "?api_key=\(Tokens.apiKeyGiphy)&q=\(word)"
    }
}
