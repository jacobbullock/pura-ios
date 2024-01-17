//
//  Giphy.swift
//  SampleApp
//
//  Created by Jacob Bullock on 1/16/24.
//

import Foundation

struct Giphy: Codable {
    var imageData: [ImageData]
    
    enum CodingKeys: String, CodingKey {
        case imageData = "data"
    }
}

extension Giphy {
    struct ImageData: Codable {
        var images: Images
    }
    
    struct Images: Codable {
        var original: Original
    }
    
    struct Original: Codable {
        var mp4: String
    }
}
