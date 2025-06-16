//
//  GetPortfolioRequest.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

import Foundation

struct GetPortfolioRequest: NetworkRequest {
    
    var requestPath: String {
        NetworkConstants.path
    }
    
}
