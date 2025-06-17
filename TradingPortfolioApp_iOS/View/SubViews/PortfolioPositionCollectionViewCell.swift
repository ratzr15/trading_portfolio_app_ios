//
//  PortfolioPositionCollectionViewCell.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

import UIKit
import SnapKit

class PortfolioPositionCell: UICollectionViewCell {
    static let reuseIdentifier = "PortfolioPositionCell"
    
    let realTimePriceView = RealTimePriceView()
    private var priceViewModel: RealTimePriceViewModel?
    let tickerLabel = UILabel()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(realTimePriceView)
        contentView.addSubview(tickerLabel)
        contentView.addSubview(nameLabel)
        
        tickerLabel.font = UIFont.systemFont(ofSize: FontSize.heading, weight: .bold)
        tickerLabel.textColor = .label
        
        nameLabel.font = UIFont.systemFont(ofSize: FontSize.title, weight: .regular)
        nameLabel.textColor = .secondaryLabel
        
        realTimePriceView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Spacing.small)
            make.centerY.equalTo(contentView)
            make.width.equalTo(90)
            make.height.equalTo(70)
        }
        
        tickerLabel.snp.makeConstraints { make in
            make.leading.equalTo(realTimePriceView.snp.trailing).offset(Spacing.small)
            make.trailing.equalTo(contentView).offset(-Spacing.small)
            make.top.equalTo(contentView).offset(Spacing.small)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(realTimePriceView.snp.trailing).offset(Spacing.small)
            make.trailing.equalTo(contentView).offset(-Spacing.small)
            make.top.equalTo(tickerLabel.snp.bottom).offset(Spacing.xxs)
        }
    }
    
    func configure(with position: Position) {
        tickerLabel.text = position.instrument.ticker
        nameLabel.text = position.instrument.name
        
        priceViewModel = RealTimePriceViewModel(initialPosition: position)
        realTimePriceView.configure(with: priceViewModel!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        priceViewModel = nil
    }
    
}
