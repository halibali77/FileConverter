//
//  FileDetailViewController.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 05/10/2024.
//

import UIKit

final class FileDetailViewController: UIViewController {
    let viewModel: FileDetailViewModel

    init(viewModel: FileDetailViewModel) {
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


private extension FileDetailViewController {
    func configureUI() {

    }
}
