//
//  RMPeopleModel.swift
//  SWCore
//
//  Created by Horacio Guzman on 3/04/25.
//

import Foundation

public struct SWPeopleModel: Decodable {
    public let name: String
    public let films: [URL]
}

public struct SWPeopleResponse: Decodable {
    public let results: [SWPeopleModel]
}


