//
//  SWPeopleView.swift
//  StarWars
//
//  Created by Simon Parraga on 2/05/25.
//

import Foundation
import SwiftUI
import SWCore

struct SWPeopleView: View {
    
    @State private var viewModel: SWPeopleViewModel

    init() {
        let fetcher = SWNetworkFecther()
        let provider = SWPeopleDataProvider(networkFetcher: fetcher)
        _viewModel = State(wrappedValue: SWPeopleViewModel(provider: provider))
    }

    var body: some View {
        NavigationStack {
            List(viewModel.people, id: \.name) { person in
                VStack(alignment: .leading) {
                    Text(person.name)
                        .font(.headline)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
            }
            .navigationTitle("People")
            .onAppear {
                viewModel.fetchPeople(page: 1)
            }
        }
    }
}
