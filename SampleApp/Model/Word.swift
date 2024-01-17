//
//  WordResponse.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


struct Word: Codable {
    let meta: Meta
    let definitions: [String]
    let wordClass: String?
    var text: String!
    var synonym: Synonym?
    var giphy: Giphy?
    
    var synonyms: [String] {
        synonym?.meta.syns.first ?? []
    }
    
    var images: [String] {
        Array(giphy?.imageData.compactMap { $0.images.original.mp4 }.prefix(7) ?? [])
    }
    
    enum CodingKeys: String, CodingKey {
        case meta
        case definitions = "shortdef"
        case wordClass = "fl"
    }
}

extension Word {
    struct Meta: Codable {
        let id: String
        let uuid: String
        let sort: String
        let stems: [String]
        let offensive: Bool
    }
}
