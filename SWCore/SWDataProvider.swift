
import Foundation

struct RMPeople {
    
}

struct SWPeopleProvider {
    
    let networkFetcher: SWNetworkFecther
    
    init(networkFetcher: SWNetworkFecther) {
        self.networkFetcher = networkFetcher
    }
    
    func getPeopleById(id: Int) async throws -> SWPeopleResponse {
        let endpoint = SWPeopleEndpoint.peopleById(id)
        return try await networkFetcher.fetch(endpoint: endpoint)
    }
}
