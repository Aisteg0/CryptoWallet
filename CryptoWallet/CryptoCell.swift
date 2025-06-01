//
//  CryptoCell.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 29.05.2025.
//

import UIKit

class CryptoCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let leftStack = UIStackView(arrangedSubviews: [nameLabel, symbolLabel])
        leftStack.axis = .vertical
        leftStack.spacing = 4
        
        let rightStack = UIStackView(arrangedSubviews: [priceLabel, changeLabel])
        rightStack.axis = .vertical
        rightStack.spacing = 4
        rightStack.alignment = .trailing
        
        let mainStack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        mainStack.axis = .horizontal
        mainStack.distribution = .fillEqually
        contentView.addSubview(mainStack)
        
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    func configure(with crypto: CryptoDetailData) {
        nameLabel.text = crypto.name
        symbolLabel.text = crypto.symbol
        priceLabel.text = String(format: "$%.2f", crypto.price)
        
        let changeText = String(format: "%.2f%%", crypto.change24h)
        changeLabel.text = crypto.change24h >= 0 ? "+\(changeText)" : changeText
        changeLabel.textColor = crypto.change24h >= 0 ? .systemGreen : .systemRed
    }
}
