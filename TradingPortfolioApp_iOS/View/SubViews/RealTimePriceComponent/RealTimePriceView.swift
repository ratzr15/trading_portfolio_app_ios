//
//  RealTimePriceView.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RealTimePriceView: UIView {
    let valueLabel = UILabel()
    private var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor(red: 255/255, green: 247/255, blue: 200/255, alpha: 1.0)
        layer.cornerRadius = UIConstants.radius
        clipsToBounds = true

        valueLabel.font = UIFont.systemFont(ofSize: FontSize.title, weight: .semibold)
        valueLabel.textColor = .darkGray
        valueLabel.numberOfLines = 0
        valueLabel.textAlignment = .center
        addSubview(valueLabel)

        valueLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.xs)
        }
    }

    func configure(with viewModel: RealTimePriceViewModelContractor) {
        disposeBag = DisposeBag()

        viewModel.formattedMarketValue
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
