//
//  CustomTabBarController.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 29.05.2025.
//

import UIKit

public class CustomTabBarController: UITabBarController {
  
  //  MARK: - Private variables
  
  private var window: UIWindow?
  
  //  MARK: - Override methods
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    tabBar.backgroundColor = .white
    configureTabs()
  }
  
  //  MARK: - Private methods
  
  private func configureTabs() {
      let tabs: [RootTab] = [.profile, .statistic, .wallet, .info, .person]
    let controllers = tabs.map { tab -> UIViewController in
      let viewController = configureViewControllers(for: tab)
      let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.image)
      return navigationController
    }

    viewControllers = controllers
  }
  
  @MainActor
  private func configureViewControllers(for tab: RootTab) -> UIViewController {
    switch tab {
    case .profile:
        let vc = CryptoViewController()
      return vc
    case .statistic:
        let vc = EmptyViewController()
        return vc
    case .wallet:
        let vc = EmptyViewController()
        return vc
    case .info:
        let vc = EmptyViewController()
        return vc
    case .person:
        let vc = EmptyViewController()
        return vc
    }
  }
}

// MARK: - Constants

private enum Constants {
  static let shadowHeigh: CGFloat = 2
  static let shadowOpacity: Float = 0.7
}
