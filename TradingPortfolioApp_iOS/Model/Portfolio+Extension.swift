//
//  Portfolio+Extension.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

extension PortfolioResponse {
    static var dummy: PortfolioResponse {
        PortfolioResponse(
            portfolio: Portfolio(
                balance: Balance(netValue: 32432.54, pnl: 10332.55, pnlPercentage: 31.52),
                positions: [
                    Position(
                        instrument: Instrument(ticker: "SXR8", name: "iShares Core S&P 500", exchange: "IBIS", currency: "EUR", lastTradedPrice: 611.64),
                        quantity: 8.4, averagePrice: 393.77, cost: 3307.7, marketValue: 5134, pnl: 1829.24, pnlPercentage: 55.2
                    ),
                    Position(
                        instrument: Instrument(ticker: "GOOG", name: "Alphabet Inc.", exchange: "NASDAQ", currency: "USD", lastTradedPrice: 183.73),
                        quantity: 12.1, averagePrice: 88.16, cost: 1066.7, marketValue: 2220.4, pnl: 1155.8, pnlPercentage: 108.1
                    ),
                    Position(
                        instrument: Instrument(ticker: "TPR", name: "Tapestry Inc.", exchange: "NYSE", currency: "USD", lastTradedPrice: 61.56),
                        quantity: 11, averagePrice: 25.25, cost: 277.7, marketValue: 677, pnl: 399, pnlPercentage: 143.6
                    ),
                    Position(
                        instrument: Instrument(ticker: "QCOM", name: "Qualcomm Inc.", exchange: "NASDAQ", currency: "USD", lastTradedPrice: 157.2),
                        quantity: 5, averagePrice: 147.76, cost: 738.8, marketValue: 785.6, pnl: 46.9, pnlPercentage: 6.34
                    ),
                    Position(
                        instrument: Instrument(ticker: "TSCO", name: "Tesco Plc.", exchange: "LSE", currency: "GBP", lastTradedPrice: 368.6),
                        quantity: 10, averagePrice: 350, cost: 3500, marketValue: 3686, pnl: 186, pnlPercentage: 5.3
                    )
                ]
            )
        )
    }
}

extension Position {
    static var dummy1: Position { PortfolioResponse.dummy.portfolio.positions[0] }
    static var dummy2: Position { PortfolioResponse.dummy.portfolio.positions[1] }
    static var dummy3: Position { PortfolioResponse.dummy.portfolio.positions[2] }
}
