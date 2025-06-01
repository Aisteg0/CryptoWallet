//
//  LoginViewController.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 29.05.2025.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: Private variables
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "login")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 25
        textField.layer.masksToBounds = true
        textField.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 247/255, alpha: 1)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 25
        textField.layer.masksToBounds = true
        textField.backgroundColor = .systemGray6
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(red: 25/255, green: 28/255, blue: 50/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 40
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuthentication()
    }
    
    // MARK: Private methods
    
    private func checkAuthentication() {
        let isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        if isAuthenticated {
            navigateToCryptoList()
        }
    }
    
    private func setupViews() {
        view.addSubview(logoImage)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(287)
            make.height.equalTo(287)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(174)
            make.centerX.equalToSuperview()
            make.width.equalTo(325)
            make.height.equalTo(55)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.width.equalTo(325)
            make.height.equalTo(55)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.width.equalTo(325)
            make.height.equalTo(55)
        }
    }
    
    private func setupAction() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func handleLogin() {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        if username == "1234" && password == "1234" {
            UserDefaults.standard.set(true, forKey: "isAuthenticated")
            navigateToCryptoList()
        } else {
            showErrorAlert()
        }
    }
    
    private func navigateToCryptoList() {
        let cryptoListVC = CustomTabBarController()
        let navController = UINavigationController(rootViewController: cryptoListVC)
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = navController
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "Введены неправильный логин или пароль",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Повторить", style: .default))
        alert.addAction(UIAlertAction(title: "Отменить", style: .destructive) { [weak self] _ in
            self?.usernameTextField.text = ""
            self?.passwordTextField.text = ""
        })
        
        present(alert, animated: true)
    }
    
    // MARK: Objc methods
    
    @objc func loginButtonTapped() {
        handleLogin()
    }
}
