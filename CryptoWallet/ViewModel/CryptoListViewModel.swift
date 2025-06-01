//
//  CryptoViewModel.swift
//  CryptoWallet
//
//  Created by Михаил Ганин on 30.05.2025.
//

import Foundation

class CryptoListViewModel {
    private let networkService: NetworkServiceProtocol
    private var cryptoData: [String: CryptoDetailData] = [:]
    private var cryptocurrencies = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    
    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?(isLoading)
        }
    }
    
    var updateLoadingStatus: ((Bool) -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchAllCryptoData() {
        isLoading = true
        let dispatchGroup = DispatchGroup()
        
        cryptocurrencies.forEach { symbol in
            dispatchGroup.enter()
            fetchCryptoData(symbol: symbol) {
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.isLoading = false
            self?.reloadData?()
        }
    }
    
    private func fetchCryptoData(symbol: String, completion: @escaping () -> Void) {
        networkService.fetchCryptoData(symbol: symbol) { [weak self] result in
            defer { completion() }
            
            switch result {
            case .success(let response):
                let detailData = CryptoDetailData(
                    name: response.data.name,
                    symbol: response.data.symbol,
                    price: response.data.marketData.priceUsd,
                    change24h: response.data.marketData.percentChangeUsdLast24Hours
                )
                self?.cryptoData[symbol] = detailData
            case .failure(let error):
                self?.showError?(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return cryptocurrencies.count
    }
    
    func crypto(at index: Int) -> CryptoDetailData? {
        let symbol = cryptocurrencies[index]
        return cryptoData[symbol]
    }
    
    func cryptoDetailData(at index: Int) -> CryptoDetailData? {
        let symbol = cryptocurrencies[index]
        return cryptoData[symbol]
    }
    
    func sortByPriceDescending() {
            cryptocurrencies.sort { (symbol1, symbol2) -> Bool in
                let price1 = cryptoData[symbol1]?.price ?? 0
                let price2 = cryptoData[symbol2]?.price ?? 0
                return price1 > price2
            }
            reloadData?()
        }
        
        func sortByPriceAscending() {
            cryptocurrencies.sort { (symbol1, symbol2) -> Bool in
                let price1 = cryptoData[symbol1]?.price ?? 0
                let price2 = cryptoData[symbol2]?.price ?? 0
                return price1 < price2
            }
            reloadData?()
        }
}
