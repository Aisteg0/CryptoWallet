//
//  CryptoViewModel.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 30.05.2025.
//

import UIKit

class CryptoDetailViewModel {
    let cryptoData: CryptoDetailData
    
    init(cryptoData: CryptoDetailData) {
        self.cryptoData = cryptoData
    }
    
    var name: String {
        return cryptoData.name
    }
    
    var symbol: String {
        return cryptoData.symbol.uppercased()
    }
    
    var price: String {
        return formatCurrency(cryptoData.price)
    }
    
    var change24h: NSAttributedString {
        let changeText = String(format: "%.2f%%", cryptoData.change24h)
        let text = cryptoData.change24h >= 0 ? "+\(changeText)" : changeText
        let color = cryptoData.change24h >= 0 ? UIColor.systemGreen : UIColor.systemRed
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "$\(value)"
    }
}
