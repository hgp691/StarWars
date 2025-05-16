//
//  SWPeopleViewModel.swift
//  StarWars
//
//  Created by Simon Parraga on 2/05/25.
//

import Foundation
import SWCore
import Observation

@Observable
public final class SWPeopleViewModel {
    
    var people: [SWPeopleModel] = []
    
    private let provider: SWPeopleDataProvider
    
    init(provider: SWPeopleDataProvider) {
        self.provider = provider
    }
    
    @MainActor
    func fetchPeople(page: Int) {
        Task {
            do {
                let response = try await provider.getPeopleByPage(page: page)
                self.people = response.results
            } catch {
                fatalError("There are no results :c")
            }
        }
    }
}
