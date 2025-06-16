//
//  ErrorCollectionViewCell.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

import UIKit
import SnapKit

class ErrorCell: UICollectionViewCell {
    static let reuseIdentifier = "ErrorCell"
    let errorMessageLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        contentView.addSubview(errorMessageLabel)
        errorMessageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.small)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with message: String) {
        errorMessageLabel.text = message
    }
}
