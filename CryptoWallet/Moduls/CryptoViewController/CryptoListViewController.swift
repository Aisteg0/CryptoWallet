//
//  CryptoListViewController.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 29.05.2025.
//

import UIKit

class CryptoListViewController: UITableViewController {
    
    // MARK: Private variables
    
    private var viewModel: CryptoListViewModel!
    
    private var counter = 0
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
    }
    
    // MARK: Public methods
    
    func refreshData() {
        viewModel.fetchAllCryptoData()
    }
    
    // MARK: Private methods
    
    private func setupViewModel() {
        viewModel = CryptoListViewModel()
        
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.showError = { [weak self] message in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: message)
            }
        }
        
        viewModel.fetchAllCryptoData()
    }
    
    private func setupTableView() {
        tableView.register(CryptoCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        let titleLabel = UILabel()
        titleLabel.text = "Trending"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let sortButton = UIButton(type: .system)
        sortButton.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        sortButton.tintColor = .systemGray
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(sortButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        sortButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        tableView.tableHeaderView = headerView
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: Objc Methods
    
    @objc private func sortButtonTapped() {
        
        switch counter {
        case 0:
            self.viewModel.sortByPriceDescending()
            counter += 1
        default:
            self.viewModel.sortByPriceAscending()
            counter -= 1
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CryptoCell
        
        if let crypto = viewModel.crypto(at: indexPath.row) {
            cell.configure(with: crypto)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cryptoData = viewModel.cryptoDetailData(at: indexPath.row) {
            let detailVM = CryptoDetailViewModel(cryptoData: cryptoData)
            let detailVC = CryptoDetailViewController(viewModel: detailVM)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
