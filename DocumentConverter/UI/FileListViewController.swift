//
//  FileListViewController.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import Combine
import Foundation
import UIKit

final class FileListViewController: UIViewController {    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var dataSource: UICollectionViewDiffableDataSource<Int, ShaprFile> = createDatasource()
    let viewModel: FileListViewModel

    init(viewModel: FileListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

private extension FileListViewController {

    func addHeader() -> UIView {
        let titleLabel: UILabel = .init()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.text = "My Files"
        view.add(
            subview: titleLabel,
            constraints: [
                .centerX,
                .topBy(UIConstants.padding.rawValue, safeArea: true)
            ])
        return titleLabel
    }

    func addFileListing(relativeTo headerLabel: UIView) {
        collectionView.delegate = self
        collectionView.register(FileViewCell.self, forCellWithReuseIdentifier: "FileViewCell")
        view.add(
            subview: collectionView,
            constraints: [
                .topTo(UIConstants.padding.rawValue, view: headerLabel),
                .trailingBy(UIConstants.padding.rawValue, safeArea: false),
                .leadingBy(UIConstants.padding.rawValue, safeArea: false),
                .bottomBy(UIConstants.padding.rawValue, safeArea: false)
            ])
    }

    func configureUI() {
        let titleLabel = addHeader()
        addFileListing(relativeTo: titleLabel)
    }

}

extension FileListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
