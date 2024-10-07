//
//  FileDescriptorView.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 05/10/2024.
//

import UIKit

enum FileDescriptorViewAction {
    case cancelConversion
    case startConversion
    case share
}
protocol FileDescriptorViewDelegate: AnyObject {
    func fileDescriptorView( _ fileDescriptorView :FileDescriptorView, didPerformAction: FileDescriptorViewAction, for type: FileType )
}

final class FileDescriptorView: UIView {

    weak var delegate: FileDescriptorViewDelegate?
    var action: FileDescriptorViewAction = .share {
        didSet {
            switch action {
            case .cancelConversion:
                actionButton.setImage(IconSet.cancel.image, for: .normal)
            case .startConversion:
                actionButton.setImage(IconSet.play.image, for: .normal)
            case .share:
                actionButton.setImage(IconSet.share.image, for: .normal)
            }
        }
    }
    private let fileType: FileType
    private var fileDescriptor: FileDescriptor?
    private let actionButton: UIButton = .init(type: .custom)
    private let conversionProgressView = UIProgressView(progressViewStyle: .default)
    private let conversionProgressLabel: UILabel = .init()

    private let fileSizeLabel: UILabel = .init()
    private let typeLabel: UILabel = .init()



    init(fileType: FileType)  {
        self.fileType = fileType
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// MARK: - UI setup
private extension FileDescriptorView {

    func configureUI() {
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        typeLabel.textColor = .black
        typeLabel.text = fileType.rawValue
        add(
            subview: typeLabel,
            constraints: [
                .leadingBy(UIConstants.padding.rawValue, safeArea: false),
                .top
            ])
        actionButton.isHidden = true
        add(
            subview: actionButton,
            constraints: [
                .trailingBy(UIConstants.padding.rawValue, safeArea: false),
                .width(20),
                .height(20),
                .centerY
            ])

        conversionProgressView.isHidden = true
        conversionProgressView.progressTintColor = .systemBlue
        conversionProgressView.trackTintColor = .lightGray
        conversionProgressView.layer.cornerRadius = 2
        add(
            subview: conversionProgressView,
            constraints: [
                .trailingTo(UIConstants.padding.rawValue, view: actionButton),
                .widthPercent(40),
                .height(2),
                .centerY
            ])
        conversionProgressLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        conversionProgressLabel.textColor = .black
        conversionProgressLabel.text = fileType.rawValue
        add(
            subview: conversionProgressLabel,
            constraints: [
                .trailingTo(UIConstants.padding.rawValue / 2, view: conversionProgressLabel),
                .centerY
            ])

        fileSizeLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        fileSizeLabel.textColor = .black
        fileSizeLabel.text = fileType.rawValue
        add(
            subview: fileSizeLabel,
            constraints: [
                .trailingTo(UIConstants.padding.rawValue, view: actionButton),
                .centerY
            ])

    }
}

// MARK: - Update view by model
extension FileDescriptorView {
    func configure(with state: ConversionState){
        switch state {
        case .failed(let error)
        }

    }
}

// MARK: - Action
private extension FileDescriptorView {
    @objc
    func actionButtonPressed(){
        delegate?.fileDescriptorView(self, didPerformAction: action, for: fileType)
    }
}
