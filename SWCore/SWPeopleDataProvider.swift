
import Foundation

public struct SWPeopleDataProvider {
    
    public let networkFetcher: SWNetworkFecther
    
    public init(networkFetcher: SWNetworkFecther) {
        self.networkFetcher = networkFetcher
    }
    
    public func getPeopleByPage(page  : Int) async throws -> SWPeopleResponse {
        let endpoint = SWPeopleEndpoint.peopleByPage(page)
        return try await networkFetcher.fetch(endpoint: endpoint)
    }
}
