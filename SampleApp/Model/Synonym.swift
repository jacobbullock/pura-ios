//
//  Synonym.swift
//  SampleApp
//
//  Created by Jacob Bullock on 1/16/24.
//

import Foundation

struct Synonym: Codable {
    let meta: Meta
}

extension Synonym {
    struct Meta: Codable {
        let syns: [[String]]
    }
}
