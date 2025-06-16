//
//  Position.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

struct Position: Codable, Equatable, Identifiable {
    let instrument: Instrument
    let quantity: Double
    let averagePrice: Double
    let cost: Double
    let marketValue: Double
    let pnl: Double
    let pnlPercentage: Double

    var id: String { instrument.ticker }
}
