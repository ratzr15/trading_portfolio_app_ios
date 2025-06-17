//
//  PortfolioViewController.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 15/06/2025.
//

import UIKit

class PortfolioViewController: UIViewController {

    var collectionView: UICollectionView!
    private var viewModel: PortfolioViewModelContractor!

    convenience init(viewModel: PortfolioViewModelContractor) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
           super.init(coder: coder)
           self.viewModel = PortfolioViewModel(networkManager: NetworkManager())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Live Price"

        setupCollectionView()
        setupViewModelBindings()
        viewModel.loadPortfolio()
    }

    private func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(PortfolioPositionCell.self, forCellWithReuseIdentifier: PortfolioPositionCell.reuseIdentifier)
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.reuseIdentifier)
        collectionView.register(ErrorCell.self, forCellWithReuseIdentifier: ErrorCell.reuseIdentifier)

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupViewModelBindings() {
        viewModel.onPortfolioFetchStart = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

        viewModel.onPortfolioFetchCompleted = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

        viewModel.onPortfolioFetchError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                print("Error: \(errorMessage)")
                self?.collectionView.reloadData()
            }
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIConstants.minimumWidth),
                                              heightDimension: .estimated(UIConstants.maximumWidth))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIConstants.minimumWidth),
                                               heightDimension: .estimated(UIConstants.maximumWidth))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: UIConstants.padding,
                                                        leading: 0,
                                                        bottom: UIConstants.padding,
                                                        trailing: 0)
        section.interGroupSpacing = Spacing.xs

        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - UICollectionViewDataSource

extension PortfolioViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionsCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = viewModel.row(at: indexPath)

        switch row {
        case .loading:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell.reuseIdentifier, for: indexPath) as! LoadingCell
            cell.backgroundColor = .systemBackground
            cell.layer.cornerRadius = UIConstants.radius
            return cell
        case .error(let message):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorCell.reuseIdentifier, for: indexPath) as! ErrorCell
            cell.configure(with: message)
            cell.backgroundColor = .systemBackground
            cell.layer.cornerRadius = UIConstants.radius
            return cell
        case .portfolio(let position):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortfolioPositionCell.reuseIdentifier, for: indexPath) as! PortfolioPositionCell
            cell.configure(with: position)
            cell.backgroundColor = .systemBackground
            cell.layer.cornerRadius = UIConstants.radius
            cell.layer.masksToBounds = true
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension PortfolioViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = viewModel.row(at: indexPath)
        if case .portfolio(let position) = row {
            //TODO: Implement navigation
        }
    }
}

