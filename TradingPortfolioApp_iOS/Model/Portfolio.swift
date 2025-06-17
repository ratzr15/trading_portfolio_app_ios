//
//  Portfolio.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

struct Portfolio: Codable, Equatable {
    let balance: Balance
    let positions: [Position]
}
