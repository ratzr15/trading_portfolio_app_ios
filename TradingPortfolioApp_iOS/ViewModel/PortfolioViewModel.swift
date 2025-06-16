//
//  PortfolioViewModel.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

import Foundation
import UIKit

internal enum PortfolioCollectionView {
    enum Rows {
        case loading
        case error(message: String)
        case portfolio(position: Position)
    }
}


internal final class PortfolioViewModel: PortfolioViewModelContractor {
    
    private let networkManager: NetworkManager
    
    private var dataSource: [Section<Void, PortfolioCollectionView.Rows>] = []
    
    var onPortfolioFetchStart: (() -> ())?
    
    var onPortfolioFetchCompleted: (() -> ())?
    
    var onPortfolioFetchError: ((String) -> ())?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func loadPortfolio() {
        onPortfolioFetchStart?()
        updateDataSource(with: .loading)
        
        let request = GetPortfolioRequest()
        
        networkManager.processRequest(request: request, type: PortfolioResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.updateDataSource(with: .portfolio(response.portfolio.positions))
                self.onPortfolioFetchCompleted?()
            case .failure(let error):
                self.updateDataSource(with: .error(error.localizedDescription))
                self.onPortfolioFetchError?(error.localizedDescription)
            }
        }
    }
    
    private func updateDataSource(with state: PortfolioListState) {
        switch state {
        case .loading:
            dataSource = [Section(rows: [.loading])]
        case .error(let message):
            dataSource = [Section(rows: [.error(message: message)])]
        case .portfolio(let positions):
            if positions.isEmpty {
                dataSource = []
            } else {
                let portfolioRows = positions.map { PortfolioCollectionView.Rows.portfolio(position: $0) }
                dataSource = [Section(rows: portfolioRows)]
            }
        }
    }
    
    var sectionsCount: Int {
        return dataSource.count
    }
    
    func section(at index: Int) -> Section<Void, PortfolioCollectionView.Rows> {
        guard index < dataSource.count else {
            fatalError("Section index out of bounds")
        }
        return dataSource[index]
    }
    
    func row(at indexPath: IndexPath) -> PortfolioCollectionView.Rows {
        guard indexPath.section < dataSource.count,
              indexPath.row < dataSource[indexPath.section].rows.count else {
            fatalError("Row index out of bounds")
        }
        return dataSource[indexPath.section].rows[indexPath.row]
    }
    
    func numberOfRows(section index: Int) -> Int {
        guard index < dataSource.count else {
            return 0
        }
        return dataSource[index].rows.count
    }
    
    private enum PortfolioListState {
        case loading
        case error(String)
        case portfolio([Position])
    }
}
