//
//  RMPeopleModel.swift
//  SWCore
//
//  Created by Horacio Guzman on 3/04/25.
//

import Foundation

struct SWPeopleModel: Decodable {
    let name: String
    let films: [URL]
}

struct SWPeopleResponse: Decodable {
    let results: [SWPeopleModel]
}


