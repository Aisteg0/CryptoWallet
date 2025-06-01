//
//  Model.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 29.05.2025.
//

import Foundation

struct CryptoResponse: Codable {
    let data: CryptoData
}

struct CryptoData: Codable {
    let name: String
    let symbol: String
    let marketData: MarketData
    
    enum CodingKeys: String, CodingKey {
        case name, symbol
        case marketData = "market_data"
    }
}

struct MarketData: Codable {
    let priceUsd: Double
    let percentChangeUsdLast24Hours: Double
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
    }
}
