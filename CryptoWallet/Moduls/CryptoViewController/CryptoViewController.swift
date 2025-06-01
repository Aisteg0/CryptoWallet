//
//  CryptoViewController.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 29.05.2025.
//

import UIKit
import SnapKit

class CryptoViewController: UIViewController {
    
    // MARK: Private variables
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 154/255, blue: 178/255, alpha: 1)
        view.clipsToBounds = false
        return view
    }()
    
    // Контейнер для таблицы
    private let tableContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    
    private let menuButton: UIButton = {
        let button = CustomButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = UIColor(red: 25/255, green: 28/255, blue: 50/255, alpha: 1)
        button.backgroundColor = UIColor(white: 1, alpha: 0.2)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let cryptoListVC = CryptoListViewController()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        embedTableView()
        setupActions()
    }
    
    // MARK: Private methods
    
    private func setupViews() {
        view.addSubview(topContainerView)
        
        topContainerView.addSubview(titleLabel)
        topContainerView.addSubview(menuButton)
        view.addSubview(tableContainerView)
        topContainerView.bringSubviewToFront(menuButton)
        
        
    }
    
    private func setupConstraints() {
        topContainerView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(258)
        }
        
        tableContainerView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom).offset(-30)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(25)
            make.top.equalToSuperview().offset(120)
        }
        
        menuButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(120)
            make.width.height.equalTo(48)
        }
    }
    
    private func embedTableView() {
        
        addChild(cryptoListVC)
        tableContainerView.addSubview(cryptoListVC.view)
        cryptoListVC.view.frame = tableContainerView.bounds
        cryptoListVC.didMove(toParent: self)
    }
    
    private func setupActions() {
        menuButton.menu = UIMenu(title: "", children: [
            UIAction(title: "Обновить", image: UIImage(systemName: "arrow.clockwise")) { _ in
                self.handleRefresh()
            },
            UIAction(title: "Выйти", image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), attributes: .destructive) { _ in
                self.handleLogout()
            }
        ])
        menuButton.showsMenuAsPrimaryAction = true
    }
    
    private func handleRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.cryptoListVC.refreshData()
        }
    }
    
    private func handleLogout() {
        let alert = UIAlertController(
            title: "Выход",
            message: "Вы уверены, что хотите выйти?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive) { _ in
            self.performLogout()
        })
        
        present(alert, animated: true)
    }
    
    private func performLogout() {
        UserDefaults.standard.removeObject(forKey: "isAuthenticated")
        let authVC = LoginViewController()
        authVC.modalPresentationStyle = .fullScreen
        
        UIView.transition(
            with: UIApplication.shared.windows.first!,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
                UIApplication.shared.windows.first?.rootViewController = authVC
            },
            completion: nil
        )
    }
}
