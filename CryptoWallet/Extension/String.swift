//
//  String.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 29.05.2025.
//

import UIKit

extension String {
    static func localize(_ key: String) -> String {
        return Bundle.main.localizedString(forKey: key, value: "", table: "Localizable")
    }
}
