//
//  NetworkService.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 30.05.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCryptoData(symbol: String, completion: @escaping (Result<CryptoResponse, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private init() {}
    
    private let baseURL = "https://data.messari.io/api/v1/assets"
    
    func fetchCryptoData(symbol: String, completion: @escaping (Result<CryptoResponse, Error>) -> Void) {
        let urlString = "\(baseURL)/\(symbol)/metrics"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CryptoResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
