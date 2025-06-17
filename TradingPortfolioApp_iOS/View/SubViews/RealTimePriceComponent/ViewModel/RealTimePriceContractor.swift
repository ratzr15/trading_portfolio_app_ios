//
//  RealTimePriceContractor.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

import RxSwift

protocol RealTimePriceViewModelContractor {
    var formattedMarketValue: Observable<String> { get }
}
