//
//  PortfolioViewModelContractor.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

import Foundation

internal protocol PortfolioViewModelContractor {
    
    /// loads all portfolio for the user from the backend.
    func loadPortfolio()
    
    /// A closure called before fetching portfolio list started.
    var onPortfolioFetchStart: (() -> ())? { get set }

    /// A closure called after fetching portfolio list succeed.
    var onPortfolioFetchCompleted: (() -> ())? { get set }

    /// A closure called after fetching categories
    var onPortfolioFetchError: ((String) -> ())? { get set } 

    /// An amount of sections contained in the table view.
    var sectionsCount: Int { get }

    /// Accesses the table view's data source to obtain the desired section.
    ///
    /// - Parameter at: an index of section that you wish to get.
    /// - Returns: a section at given index.
    func section(at index: Int) -> Section<Void, PortfolioCollectionView.Rows>

    /// Accesses the table view's data source and returns a row under given index path.
    ///
    /// - Parameter at: an index path you wish to access.
    /// - Returns: a row at given index path.
    func row(at indexPath: IndexPath) -> PortfolioCollectionView.Rows

    /// Accesses the table view's data source to obtain the amount of rows contained in a given section.
    ///
    /// - Parameter section: a section you wish to have data about.
    /// - Returns: the amount of rows in section at given index.
    func numberOfRows(section: Int) -> Int
}
