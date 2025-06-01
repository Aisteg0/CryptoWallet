//
//  RootBar.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 29.05.2025.
//

import UIKit

enum RootTab {
    case profile
    case statistic
    case wallet
    case info
    case person
    
    var title: String {
        switch self {
        case .profile:
            return .localize("home")
        case .statistic:
            return .localize("statistic")
        case .wallet:
            return .localize("wallet")
        case .info:
            return .localize("info")
        case .person:
            return .localize("person")
        }
    }
    
    var image: UIImage? {
      switch self {
      case .profile:
          return Assets.profile
      case .statistic:
          return Assets.statistic
      case .wallet:
          return Assets.statistic
      case .info:
          return Assets.statistic
      case .person:
          return Assets.statistic
      }
    }
}
