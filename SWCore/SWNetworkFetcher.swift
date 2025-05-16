import Foundation

public struct SWNetworkFecther {
    
    enum NetworkingServerError: Error {
        case userError
        case serverError
        case invalidResponse
    }
    
    public let urlSession: URLSession
    public let decoder: JSONDecoder
    
    public init(urlSession: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func fetch<T: Decodable>(endpoint: SWEndpoint) async throws -> T {
        let (data, response) = try await urlSession.data(for: endpoint.urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingServerError.invalidResponse
        }
        switch httpResponse.statusCode {
        case 200..<300:
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        case 400..<500:
            throw NetworkingServerError.userError
        default:
            throw NetworkingServerError.serverError
        }
    }

}
