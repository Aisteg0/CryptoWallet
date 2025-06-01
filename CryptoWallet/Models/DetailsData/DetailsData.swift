//
//  DetailsData.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 30.05.2025.
//

import UIKit

struct CryptoDetailData {
    let name: String
    let symbol: String
    let price: Double
    let change24h: Double
   
    init(name: String, symbol: String, price: Double, change24h: Double) {
        self.name = name
        self.symbol = symbol
        self.price = price
        self.change24h = change24h
    }
}
