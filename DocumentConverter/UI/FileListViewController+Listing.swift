//
//  FileListViewController+Listing.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import UIKit

extension FileListViewController {
    // MARK: - Layout Configuration
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            // Calculate the number of columns based on the available width
            let availableWidth = environment.container.effectiveContentSize.width
            let columns: Int
            if availableWidth > 800 {
                columns = 4
            } else if availableWidth > 600 {
                columns = 3
            } else {
                columns = 2
            }

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)

            let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                return section
            }
        }

    // MARK: - Data Source Configuration
    func createDatasource() -> UICollectionViewDiffableDataSource<Int, ShaprFile> {
        UICollectionViewDiffableDataSource<Int, ShaprFile>(collectionView: collectionView) { [weak self] collectionView, indexPath, model -> UICollectionViewCell? in
            guard let self
            else {
                return nil
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FileViewCell.self),
                                                          for: indexPath) as? FileViewCell
            cell?.configure(
                with: model,
                imageFetcher: viewModel.imageFetcher,
                conversionPublisher: viewModel.conversionPublisher
            )
            return cell
        }
    }

}
