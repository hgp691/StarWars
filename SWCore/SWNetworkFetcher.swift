import Foundation

struct SWNetworkFecther {
    
    let urlSession: URLSession
    let decoder: JSONDecoder
    
    init(urlSession: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func fetch<T: Decodable>(endpoint: SWEndpoint) async throws -> T {
        let (data, _) = try await urlSession.data(for: endpoint.urlRequest)
        let response = try decoder.decode(T.self, from: data)
        return response
    }
    
    
}
