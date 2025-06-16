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

    let valueBox = UIView()
    let valueLabel = UILabel()
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
        valueBox.backgroundColor = UIColor(red: 255/255, green: 247/255, blue: 200/255, alpha: 1.0)
        valueBox.layer.cornerRadius = 8
        valueBox.clipsToBounds = true
        contentView.addSubview(valueBox)

        valueLabel.font = UIFont.systemFont(ofSize: FontSize.title, weight: .semibold)
        valueLabel.textColor = .darkGray
        valueLabel.numberOfLines = 0
        valueLabel.textAlignment = .center
        valueBox.addSubview(valueLabel)

        tickerLabel.font = UIFont.systemFont(ofSize: FontSize.heading, weight: .bold)
        tickerLabel.textColor = .label
        contentView.addSubview(tickerLabel)

        nameLabel.font = UIFont.systemFont(ofSize: FontSize.title, weight: .regular)
        nameLabel.textColor = .secondaryLabel
        contentView.addSubview(nameLabel)

        valueBox.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Spacing.small)
            make.centerY.equalTo(contentView)
            make.width.equalTo(90)
            make.height.equalTo(70)
        }

        valueLabel.snp.makeConstraints { make in
            make.edges.equalTo(valueBox).inset(Spacing.xs)
        }
        
        tickerLabel.snp.makeConstraints { make in
            make.leading.equalTo(valueBox.snp.trailing).offset(Spacing.small)
            make.trailing.equalTo(contentView).offset(-Spacing.small)
            make.top.equalTo(contentView).offset(Spacing.small)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(valueBox.snp.trailing).offset(Spacing.small)
            make.trailing.equalTo(contentView).offset(-Spacing.small)
            make.top.equalTo(tickerLabel.snp.bottom).offset(Spacing.xxs)
        }
    }

    func configure(with position: Position) {
        tickerLabel.text = position.instrument.ticker
        nameLabel.text = position.instrument.name

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = position.instrument.currency
        valueLabel.text = formatter.string(from: NSNumber(value: position.marketValue))
    }
}
