//
//  Instrument.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

struct Instrument: Codable, Equatable, Identifiable {
    let ticker: String
    let name: String
    let exchange: String
    let currency: String
    let lastTradedPrice: Double

    var id: String { ticker }
}
