//
//  ImageFetcher.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 03/10/2024.
//
import UIKit

public protocol ImageFetcher {
    func load(url: URL?, imageView: UIImageView)
}
