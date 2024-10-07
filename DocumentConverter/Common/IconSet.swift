//
//  IconSet.swift
//  DocumentConverter
//
//  Created by Balint Halasz on 05/10/2024.
//
import UIKit
public enum IconSet: String, Decodable {
    case cancel
    case play
    case share

    public var image: UIImage? {
        return UIImage(named: rawValue)
    }
}
