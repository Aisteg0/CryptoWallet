//
//  CustomButton.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 31.05.2025.
//

import UIKit

class CustomButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let radius = bounds.width / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        return pow(point.x - center.x, 2) + pow(point.y - center.y, 2) <= pow(radius, 2)
    }
}
