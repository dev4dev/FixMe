//
//  ViewController.swift
//  FixMe
//
//  Created by Alex Antonyuk on 13.07.2023.
//

import UIKit
import SnapKit
import SwiftUI

enum Section: Int {
    case main
}

enum Item: String, CaseIterable {
    case leaks
    case swiftUI
}

final class ViewController: UIViewController {

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        addData()
    }

    private func setup() {
        let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Item> = .init { cell, indexPath, itemIdentifier in
            var config = cell.defaultContentConfiguration()
            config.text = itemIdentifier.rawValue.capitalized
            cell.contentConfiguration = config
        }

        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }

    private func addData() {
        var snapshot: NSDiffableDataSourceSnapshot<Section, Item> = .init()

        snapshot.appendSections([.main])
        snapshot.appendItems(Item.allCases, toSection: .main)

        dataSource.apply(snapshot)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }

        switch item {
        case .leaks:
            navigationController?.pushViewController(LeaksViewController(), animated: true)
        case .swiftUI:
            navigationController?.pushViewController(UIHostingController(rootView: SwiftUIView(counter: 5)), animated: true)
        }

        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
