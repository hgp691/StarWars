//
//  SWPeopleTest.swift
//  StarWarsTests
//
//  Created by Horacio Guzman on 3/04/25.
//

import XCTest
@testable import SWCore

final class NetworkFetcherTest: XCTestCase {
    
    var urlSession: URLSession!
    
    override func setUp() async throws {
        
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession(configuration: configuration)
        self.urlSession = urlSession
    }
    
    override func tearDown() async throws {
        urlSession = nil
    }

    func testNetworkFetcherIsCorrect() async throws {
        
        // Given
        let jsonString = SWMockResponses.peopleIdResponse
        let data = try XCTUnwrap(jsonString.data(using: .utf8))
        
        URLProtocolMock.requestHandler = { request in
            let response = try XCTUnwrap(HTTPURLResponse(url: URL(string: "https://swapi.dev/api/people/1/")!,
                                                     statusCode: 200,
                                                     httpVersion: nil,
                                                     headerFields: ["Content-Type:": "application/json"]))
            
            return (response, data)
        }
        
        let networkFetcher = SWNetworkFecther(urlSession: urlSession)
        let endpoint = SWPeopleEndpoint.peopleById(1)
        
        // When
        let people: SWPeopleModel = try await networkFetcher.fetch(endpoint: endpoint)
        
        //Then
        XCTAssertNotNil(people)
    }
    
    func testNetworkFetcherGotInvalidData() async throws {
        
        // Given
        let jsonString = SWMockResponses.peopleIdInvalidResponse
        let data = try XCTUnwrap(jsonString.data(using: .utf8))
        
        URLProtocolMock.requestHandler = { request in
            let response = try XCTUnwrap(HTTPURLResponse(url: URL(string: "https://swapi.dev/api/people/1/")!,
                                                     statusCode: 200,
                                                     httpVersion: nil,
                                                     headerFields: ["Content-Type:": "application/json"]))
            
            return (response, data)
        }
        
        let networkFetcher = SWNetworkFecther(urlSession: urlSession)
        let endpoint = SWPeopleEndpoint.peopleById(1)
        
        // Then
        do {
            let people: SWPeopleModel = try await networkFetcher.fetch(endpoint: endpoint)
            XCTFail()
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testNetworkFetcherGotUserError() async throws {
        
        // Given
        let userError = SWNetworkFecther.NetworkingServerError.userError
        let jsonString = SWMockResponses.peopleIdInvalidResponse
        let data = try XCTUnwrap(jsonString.data(using: .utf8))
        
        URLProtocolMock.requestHandler = { request in
            let response = try XCTUnwrap(HTTPURLResponse(url: URL(string: "https://swapi.dev/api/people/1/")!,
                                                     statusCode: 403,
                                                     httpVersion: nil,
                                                     headerFields: ["Content-Type:": "application/json"]))
            
            return (response, data)
        }
        
        let networkFetcher = SWNetworkFecther(urlSession: urlSession)
        let endpoint = SWPeopleEndpoint.peopleById(1)
        
        // Then
        do {
            let people: SWPeopleModel = try await networkFetcher.fetch(endpoint: endpoint)
            XCTFail()
        } catch {
            XCTAssertEqual(try XCTUnwrap(error as? SWNetworkFecther.NetworkingServerError), userError)
        }
    }
    
    func testNetworkFetcherGotServerError() async throws {
        
        // Given
        let userError = SWNetworkFecther.NetworkingServerError.serverError
        let jsonString = SWMockResponses.peopleIdResponse
        let data = try XCTUnwrap(jsonString.data(using: .utf8))
        
        URLProtocolMock.requestHandler = { request in
            let response = try XCTUnwrap(HTTPURLResponse(url: URL(string: "https://swapi.dev/api/people/1/")!,
                                                     statusCode: 503,
                                                     httpVersion: nil,
                                                     headerFields: ["Content-Type:": "application/json"]))
            
            return (response, data)
        }
        
        let networkFetcher = SWNetworkFecther(urlSession: urlSession)
        let endpoint = SWPeopleEndpoint.peopleById(1)
        
        // Then
        do {
            let people: SWPeopleModel = try await networkFetcher.fetch(endpoint: endpoint)
            XCTFail()
        } catch {
            XCTAssertEqual(try XCTUnwrap(error as? SWNetworkFecther.NetworkingServerError), userError)
        }
    }
    
    func testNetworkFetcherGotinvalidResponse() async throws {
        
        // Given
        let userError = SWNetworkFecther.NetworkingServerError.invalidResponse
        let jsonString = SWMockResponses.peopleIdInvalidResponse
        let data = try XCTUnwrap(jsonString.data(using: .utf8))
        
        URLProtocolMock.requestHandler = { request in
            let response = try XCTUnwrap(URLResponse(
                    url: URL(string: "https://swapi.dev/api/people/1/")!,
                    mimeType: nil,
                    expectedContentLength: 0,
                    textEncodingName: nil
                ))
            
            return (response, data)
        }
        
        let networkFetcher = SWNetworkFecther(urlSession: urlSession)
        let endpoint = SWPeopleEndpoint.peopleById(1)
        
        // Then
        do {
            let people: SWPeopleModel = try await networkFetcher.fetch(endpoint: endpoint)
            XCTFail()
        } catch {
            XCTAssertEqual(try XCTUnwrap(error as? SWNetworkFecther.NetworkingServerError), userError)
        }
    }
}


class URLProtocolMock: URLProtocol {
    
    static var error: Error?
    static var requestHandler: ((URLRequest) throws -> (URLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        if let error = Self.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        do {
            guard let handler = Self.requestHandler else {
                return
            }
            
            do {
                let (response, data) = try handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
    }
    
    override func stopLoading() { }
}


