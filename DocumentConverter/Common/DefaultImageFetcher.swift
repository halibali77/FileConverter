//
//  DefaultImageFetcher.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//

import SDWebImage
import UIKit


final class DefaultImageFetcher: ImageFetcher {
    public func load(url: URL?, imageView: UIImageView) {
        imageView.image = nil
        guard let url else {
            return
        }
        imageView.sd_setImage(with: url)
    }
}
