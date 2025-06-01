//
//  CryptoDetailViewController.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 30.05.2025.
//

import UIKit
import SnapKit

class CryptoDetailViewController: UIViewController {
    
    private let viewModel: CryptoDetailViewModel
    
    // MARK: Private variables
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor(red: 244/255, green: 245/255, blue: 246/255, alpha: 1)
        return scroll
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()
    
    private let contentStackView2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        
        return label
    }()
    
    private let timePeriodSegmentedControl: UISegmentedControl = {
        let items = ["24H", "1W", "1Y", "ALL", "Point"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.backgroundColor = .systemGray6
        control.layer.cornerRadius = 25
        control.selectedSegmentTintColor = .systemBlue
        
        return control
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let marketStatsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Market Statistic"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let marketCapView = createStatView(title: "Market capitalization")
    private let circulatingSupplyView = createStatView(title: "Circulating Supply")
    
    // MARK: - Init
    
    init(viewModel: CryptoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateUI()
        setupConstraints()
    }
    
    // MARK: Private methods
    
    private func updateUI() {
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        changeLabel.attributedText = viewModel.change24h
        title = viewModel.symbol
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        scrollView.addSubview(timePeriodSegmentedControl)
        scrollView.addSubview(contentStackView2)
        
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(priceLabel)
        contentStackView.addArrangedSubview(changeLabel)
        
        contentStackView.setCustomSpacing(24, after: changeLabel)
        
        contentStackView.addArrangedSubview(separatorView)
        
        contentStackView.setCustomSpacing(24, after: separatorView)
        
        contentStackView2.addArrangedSubview(marketStatsTitleLabel)
        contentStackView2.addArrangedSubview(marketCapView)
        contentStackView2.addArrangedSubview(circulatingSupplyView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(16)
            make.leading.trailing.equalTo(view).inset(16)
            make.width.equalTo(scrollView).offset(-32)
        }
        
        timePeriodSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(contentStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.width.equalTo(325)
        }
        
        contentStackView2.snp.makeConstraints { make in
            make.top.equalTo(timePeriodSegmentedControl.snp.bottom).offset(280)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(scrollView).offset(-20)
        }
        
        contentStackView2.spacing = 15
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        
        contentStackView2.alignment = .leading
        
        marketCapView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        circulatingSupplyView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    private static func createStatView(title: String) -> UIView {
        let view = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .secondaryLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        return view
    }
}
