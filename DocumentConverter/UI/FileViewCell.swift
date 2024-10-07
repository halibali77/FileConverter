//
//  FileViewCell.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import Combine
import UIKit

final class FileViewCell:  UICollectionViewCell {

    private  let thumbnailImageView = UIImageView()
    private let fileNameLabel = UILabel()
    private let stlLabel = UILabel()
    private let objLabel = UILabel()
    private let stepLabel = UILabel()
    private let conversionProgressView = UIProgressView(progressViewStyle: .default)
    private var cancellables = Set<AnyCancellable>()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        thumbnailImageView.image = nil
        [stlLabel, objLabel, stepLabel].forEach { $0.isHidden = true }

    }
}

private extension  FileViewCell {

    func setupUI() {
        // Progress Bars setup
        conversionProgressView.progressTintColor = .systemBlue
        conversionProgressView.trackTintColor = .lightGray
        conversionProgressView.layer.cornerRadius = 2
        conversionProgressView.isHidden = true
        contentView.add(
            subview: conversionProgressView,
            constraints: [
                .bottomBy(0, safeArea: false),
                .leading,
                .trailing
            ])


        fileNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.add(
            subview: fileNameLabel,
            constraints: [
                .bottomTo(0, view: conversionProgressView),
                .leading,
                .trailing
            ])



        thumbnailImageView.contentMode = .scaleAspectFit
        contentView.add(
            subview: thumbnailImageView,
            constraints: [
                .bottomTo(0, view: fileNameLabel),
                .top,
                .leading,
                .trailing
            ])

        let conversionMarksView = UIStackView()
        conversionMarksView.axis = .horizontal
        conversionMarksView.spacing = 2

        // Setup for STL, OBJ, and STEP Labels
        stlLabel.text = FileType.stl.rawValue
        objLabel.text = FileType.obj.rawValue
        stepLabel.text = FileType.step.rawValue
        [stlLabel, objLabel, stepLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: 12)
            label.isHidden = true
            conversionMarksView.addArrangedSubview(label)
        }

        contentView.add(
            subview: conversionMarksView,
            constraints: [
                .bottomTo(5, view: thumbnailImageView),
                .trailingTo(5, view: thumbnailImageView)
            ]
        )

    }

    func showLabel(for type: FileType) {
        switch type {
        case .obj:
            objLabel.isHidden = false
        case .sharpr:
            break
        case .step:
            stepLabel.isHidden = false
        case .stl:
            stepLabel.isHidden = false
        }
    }
}

extension FileViewCell {
    func configure(with file: ShaprFile,
                   imageFetcher: ImageFetcher,
                   conversionPublisher: AnyPublisher<ConversionEvent, Never>
    ) {
        fileNameLabel.text = file.name
        imageFetcher.load(url: file.sharprURL, imageView: thumbnailImageView)

        conversionPublisher
            .receive(on: DispatchQueue.main)
            .filter({ $0.fileName == file.name
            }).sink { [weak self] conversionEvent in
                switch conversionEvent.state {
                case .failed(let error):
                    break
                case .finished(let result):
                    self?.conversionProgressView.isHidden = true
                    self?.showLabel(for: result.type)
                case .progress(let progress):
                    self?.conversionProgressView.progress = Float(progress)
                case .queued:
                    self?.conversionProgressView.isHidden = false
                }

            }.store(in: &cancellables)
    }
}
