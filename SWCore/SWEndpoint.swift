import Foundation

protocol SWEndpoint {
    var urlRequest: URLRequest { get }
}

enum SWFilmsEndpoint: SWEndpoint {
    
    static let domain = "https://swapi.dev/api/"
    
    case filmsById(Int)
    case allFilms
    
    private var urlString: String {
        switch self {
        case .filmsById(let int):
            return Self.domain + "films/\(int)"
        case .allFilms:
            return Self.domain + "films"
        }
    }
    
    var urlRequest: URLRequest {
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
}

enum SWPeopleEndpoint: SWEndpoint {
    
    static let domain = "https://swapi.dev/api/"
    
    case peopleByPage(Int)
    case peopleById(Int)
    
    private var urlString: String {
        switch self {
        case .peopleByPage(let int):
            return Self.domain + "people/?page=\(int)"
        case .peopleById(let int):
            return Self.domain + "people/\(int)"
        }
    }
    
    var urlRequest: URLRequest {
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
}

enum SWPlanetEndpoint: SWEndpoint {
    
    static let domain = "https://swapi.dev/api/"
    
    case planetsByPage(Int)
    case planetsById(Int)
    
    private var urlString: String {
        switch self {
        case .planetsByPage(let int):
            return Self.domain + "planets/?page=\(int)"
        case .planetsById(let int):
            return Self.domain + "planets/\(int)"
        }
    }
    
    var urlRequest: URLRequest {
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
}

enum SWSpecieEndpoint: SWEndpoint {
    
    static let domain = "https://swapi.dev/api/"
    
    case speciesByPage(Int)
    case speciesById(Int)
    
    private var urlString: String {
        switch self {
        case .speciesByPage(let int):
            return Self.domain + "species/?page=\(int)"
        case .speciesById(let int):
            return Self.domain + "species/\(int)"
        }
    }
    
    var urlRequest: URLRequest {
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
}

enum SWStarshipEndpoint: SWEndpoint {
    
    static let domain = "https://swapi.dev/api/"
    
    case starshipsByPage(Int)
    case starshipsById(Int)
    
    private var urlString: String {
        switch self {
        case .starshipsByPage(let int):
            return Self.domain + "starships/?page=\(int)"
        case .starshipsById(let int):
            return Self.domain + "starships/\(int)"
        }
    }
    
    var urlRequest: URLRequest {
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
}

enum SWSVehiclesEndpoint: SWEndpoint {
    
    static let domain = "https://swapi.dev/api/"
    
    case vehiclesByPage(Int)
    case vehiclesById(Int)
    
    private var urlString: String {
        switch self {
        case .vehiclesByPage(let int):
            return Self.domain + "vehicles/?page=\(int)"
        case .vehiclesById(let int):
            return Self.domain + "vehicles/\(int)"
        }
    }
    
    var urlRequest: URLRequest {
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
}

